module EasyCallbacks
  module Repositories

    class BaseRepository

      attr_accessor :list

      def initialize(*args); self.list = [] end

      def find_or_add(*args, &block); find(*args) || add(*args, &block) end

      def add(*args, &block)
        unless exists? *args
          model_instance = block_given? ? model.new(*args, &block) : model.new(*args)
          self.list.push(model_instance)
          model_instance
        end
      end

      def exists?(*args); not find(*args).nil? end

      def find(*args); list.find &find_block(*args) end

      protected

      def find_block(*args)
        raise NotImplementedError.new("find_block@#{self.class} must overwrite find_block@#{self.class.superclass}")
      end

      def model
        raise NotImplementedError.new("model@#{self.class} must overwrite model@#{self.class.superclass}")
      end

    end

  end
end