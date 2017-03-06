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
        EasyCallbacks.decorate_method target_class_instance, target_method_name
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