require 'easy_callbacks/all'
require 'active_support/concern'

module EasyCallbacks extend ActiveSupport::Concern

  included do

    class << self

      def before(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :before, target_method_name, callback_method_name, &callback_block
      end

      def around(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :around, target_method_name, callback_method_name, &callback_block
      end

      def after(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :after, target_method_name, callback_method_name, &callback_block
      end

      def handle_callback_definition(callback_type, target_method_name, callback_method_name, &callback_block)
        EasyCallbacks.configure(self) { send callback_type, target_method_name, callback_method_name, &callback_block }
      end

    end

  end

  class << self

    attr_writer :target_classes_repository

    def configure(target_class, &cfg_block)
      target_class_instance = target_classes_repository.find_or_add target_class
      Dsls::TargetClassesDsl.new(target_class_instance).instance_eval &cfg_block
    end

    def execute_callbacks(context, target_class_instance, callback_type, target_method_name, additional_options, call_args, &call_block)
      validate_target_class_instance target_class_instance
      target_class_instance.get_callbacks_for(callback_type, target_method_name).each do |callback|
        define_callback_details_method additional_options, callback, target_class_instance
        proc = callback.callback_block
        proc.nil? ? context.send(callback.callback_method_name, *call_args, &call_block) : context.instance_eval(&proc)
      end
    end

    def define_callback_details_method(additional_options, callback, target_class_instance)
      target_class_instance.target_class.send :define_method, :callback_details do
        callback_details = Utils::Serializer.to_h(
          callback, %w(callback_type target_method_name callback_method_name callback_block)
        ).merge(target_class: target_class_instance.target_class)
        additional_options ? callback_details.merge(additional_options) : callback_details
      end
    end

    def decorate_method(target_class_instance, target_method_name)
      tci = target_class_instance
      MethodDecorator.decorate target_class_instance.target_class, target_method_name do
        EasyCallbacks.execute_callbacks self, tci, :before, target_method_name, nil, call_args, &call_block
        original_call_return = EasyCallbacks.call_original self
        EasyCallbacks.execute_callbacks self, tci, :around, target_method_name, original_call_return, call_args, &call_block
        raise original_call_return[:return_object] if original_call_return[:return_type].eql? :error
        EasyCallbacks.execute_callbacks self, tci, :after, target_method_name, nil, call_args, &call_block
        original_call_return[:return_object]
      end
    end

    def call_original(context)
      result = error = nil
      begin
        result = context.send :call_original
      rescue => e
        error = e
      end

      error ?
      { return_type: :error, return_object: error } :
      { return_type: :success, return_object: result }
    end

    protected

    def validate_target_class_instance(target_class_instance)
      Utils::Validator.validate_instance_type! :target_class_instance, target_class_instance, Models::TargetClass
    end

    def target_classes_repository
      @target_classes_repository ||= Repositories::TargetClassesRepository.new
    end

  end

end