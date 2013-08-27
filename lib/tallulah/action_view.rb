module Tallulah
  module ActionView
    class TemplateHandler
      def call(template)
        <<-RUBY
        with_tallulah do
          #{template.source}
        end
        RUBY
      end
    end
  end
end