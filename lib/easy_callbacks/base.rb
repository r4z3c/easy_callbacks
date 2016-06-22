require 'method_decorator'

module EasyCallbacks
  module Base extend ActiveSupport::Concern

    included do

      include MethodDecorator

      TYPES = %w(before around after)

      class << self

        attr_accessor :callbacks

        def method_missing(method_sym, *args, &block)
          if TYPES.include? method_sym.to_s
            target = args.first
            callback_name = args.count.eql?(1) ? nil : args.last
            handle_method_missing method_sym, target, callback_name, &block
          else
            super method_sym, *args, &block
          end
        end

        private

        def handle_method_missing(type, target, callback_name, &block)
          push_callback type, target, callback_name, &block
          decorate_target target
        end

        def push_callback(type, target, callback_name)
          initialize_callbacks type
          self.callbacks[type].push target: target,
                                    callback_name: callback_name,
                                    proc: (block_given? ? Proc.new : nil)
        end

        def initialize_callbacks(type)
          self.callbacks ||= {}
          self.callbacks[type] ||= []
        end

        def decorate_target(target)
          decorate_method target do |*args, &block|
            execute_callbacks_for :before, target, nil, *args, &block
            result, error = execute_original_method target, *args, &block

            additional_options = error ?
              { return_type: :error, return_object: error } :
              { return_type: :success, return_object: result }

            execute_callbacks_for :around, target, additional_options, *args, &block

            raise error if error

            execute_callbacks_for :after, target, nil, *args, &block

            result
          end unless method_defined? original_method_name_for(target)
        end

        def respond_to_missing?(target, include_private=false)
          TYPES.include?(target) ? true : super ;
        end

      end

      def execute_callbacks_for(type, target, additional_options, *args, &block)
        get_callbacks_for(type).select { |c| c[:target].eql? target }.each do |callback|
          cn = callback[:callback_name]
          proc = callback[:proc]
          t = callback[:target]
          arguments = args + [
              class: callbacks_holder,
              target: t,
              type: type,
              callback_name: cn,
              proc: proc
          ];

          arguments.last.merge! additional_options if additional_options

          if proc.nil?
            send(cn, *arguments, &block)
          else
            arguments.last.merge! object: self
            proc.nil? ? send(cn, *arguments, &block) : proc.call(*arguments, &block)
          end
        end
      end

      def get_callbacks_for(type)
        callbacks_holder.callbacks[type]
      end

      def callbacks_holder
        self.class.eql?(Class) ? self.singleton_class : self.class
      end

      def execute_original_method(target, *args, &block)
        result = error = nil

        begin
          result = call_original_method target, *args, &block
        rescue => e
          error = e
        end

        return result, error
      end

    end

  end
end