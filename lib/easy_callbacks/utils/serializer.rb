module EasyCallbacks
  module Utils

    class Serializer

      class << self

        def to_h(object, attrs=[])
          attrs = [attrs] unless attrs.is_a? Array
          hash = {}
          attrs.each { |k| hash[k.to_sym] = object.send k }
          hash
        end

      end

    end

  end
end