require 'method_decorator'

module EasyCallbacks
  module Dsls

    class TargetClassesDsl

      attr_accessor :target_class_instance

      def initialize(target_class_instance)
        self.target_class_instance = target_class_instance
      end

      def before(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :before, target_method_name, callback_method_name, &callback_block
      end

      def around(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :around, target_method_name, callback_method_name, &callback_block
      end

      def after(target_method_name, callback_method_name=nil, &callback_block)
        handle_callback_definition :after, target_method_name, callback_method_name, &callback_block
      end

      protected

      def handle_callback_definition(callback_type, target_method_name, callback_method_name, &callback_block)
        push_callback callback_type, target_method_name, callback_method_name, &callback_block
        decorate_method target_method_name
      end

      def push_callback(callback_type, target_method_name, callback_method_name, &callback_block)
        target_class_instance.add_callback callback_type, target_method_name, callback_method_name, &callback_block
      end

      def decorate_method(target_method_name)
        tci = target_class_instance
        MethodDecorator.decorate target_class_instance.target_class, target_method_name do
          EasyCallbacks.execute_callbacks self, tci, :before, target_method_name, nil, call_args, &call_block

          result = error = nil
          begin
            result = call_original
          rescue => e
            error = e
          end

          additional_options = error ?
            { return_type: :error, return_object: error } :
            { return_type: :success, return_object: result }

          EasyCallbacks.execute_callbacks self, tci, :around, target_method_name, additional_options, call_args, &call_block

          raise error if error

          EasyCallbacks.execute_callbacks self, tci, :after, target_method_name, nil, call_args, &call_block

          result
        end
      end

      def target_class_instance=(target_class_instance)
        validate_target_class_instance target_class_instance
        @target_class_instance = target_class_instance
      end

      def validate_target_class_instance(target_class_instance)
        Utils::Validator.validate_instance_type! :target_class_instance,
                                                target_class_instance,
                                                Models::TargetClass
      end

    end

  end
end