module EasyCallbacks
  module Repositories

    class CallbacksRepository < BaseRepository

      attr_accessor :target_class_instance

      def initialize(target_class_instance)
        super
        self.target_class_instance = target_class_instance
      end

      def get_callbacks_for(callback_type, target_method_name)
        list.select do |c|
          c.callback_type.eql?(callback_type) and
          c.target_method_name.eql?(target_method_name)
        end
      end

      protected

      def find_block(callback_type, target_method_name, callback_method_name)
        Proc.new do |item|
          item.callback_type.eql? callback_type and
          item.target_method_name.eql? target_method_name and
          item.callback_method_name.eql? callback_method_name
        end
      end

      def model; Models::Callback end

      def target_class_instance=(target_class_instance)
        validate_target_class_instance target_class_instance
        @target_class_instance = target_class_instance
      end

      def validate_target_class_instance(target_class_instance)
        Utils::Validator.validate_instance_type! :target_class_instance, target_class_instance, Models::TargetClass
      end

    end

  end
end