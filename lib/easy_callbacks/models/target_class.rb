module EasyCallbacks
  module Models

    class TargetClass

      attr_accessor :target_class, :callbacks_repository

      def initialize(target_class)
        self.target_class = target_class
        self.callbacks_repository = ::EasyCallbacks::Repositories::CallbacksRepository.new self
      end

      def add_callback(callback_type, target_method_name, callback_method_name, &callback_block)
        callbacks_repository.find_or_add callback_type, target_method_name, callback_method_name, &callback_block
      end

      def get_callbacks_for(callback_type, target_method_name)
        callbacks_repository.get_callbacks_for callback_type, target_method_name
      end

      protected

      def target_class=(target_class)
        validate_target_class target_class
        @target_class = target_class
      end

      def validate_target_class(target_class)
        Utils::Validator.validate_instance_type! :target_class, target_class, Class
      end

    end

  end
end