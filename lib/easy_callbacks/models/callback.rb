module EasyCallbacks
  module Models

    class Callback

      attr_accessor :callback_type, :target_method_name, :callback_method_name, :callback_block

      def initialize(callback_type, target_method_name, callback_method_name)
        self.callback_type = callback_type
        self.target_method_name = target_method_name
        self.callback_method_name = callback_method_name
        self.callback_block = block_given? ? Proc.new : nil
      end

    end

  end
end