module EasyCallbacks
  module Utils

    class Validator

      class << self

        def validate_instance_type!(attribute_name, instance, desired_type)
          raise TypeError.new("#{attribute_name} must be a #{desired_type}") unless instance.is_a? desired_type
        end

      end

    end

  end
end