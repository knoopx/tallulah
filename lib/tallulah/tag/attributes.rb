require 'set'
require 'active_support/hash_with_indifferent_access'

module Tallulah
  class Tag
    class Attributes
      class ClassList
        def initialize(class_list)
          @class_list = Set.new(class_list.kind_of?(String) ? class_list.split(/\s+/).compact.map(&:strip) : class_list)
        end

        def to_s
          @class_list.to_a.join(" ").strip
        end
      end

      def initialize(attributes)
        @attributes = HashWithIndifferentAccess.new
        attributes.each do |key, value|
          if respond_to?(:"#{key}=")
            send(:"#{key}=", value)
          else
            @attributes[key] = value
          end
        end
      end

      def to_s
        @attributes.inject(String.new) { |h, (k, v)| h << " #{k}=\"#{v}\"" }
      end

      def class
        ClassList.new(@attributes[:class])
      end

      def class=(string)
        @attributes[:class] = ClassList.new(string).to_s
      end

      def data
        @attributes.select { |k, _| k[/\Adata\-(.+)\Z/i] }.each_with_object({}) { |(_, v), h| h[$1] = v }
      end

      def data=(hash)
        hash.each do |key, value|
          @attributes["data-#{key}".downcase] = value
        end
      end
    end
  end
end