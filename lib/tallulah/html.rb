require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/array/extract_options'

module Tallulah
  module HTML
    class << self
      def tag(*names)
        Array.wrap(names).each do |name|
          define_method(name) do |attrs = {}|
            append_node(Tag.new(self, name, attrs))
          end
        end
      end

      def content_tag(*names)
        Array.wrap(names).each do |name|
          class_eval <<-RUBY, __FILE__, __LINE__
            def #{name}(*args)
              attrs = args.extract_options!

              tag = ContentTag.new(self, "#{name}", attrs)

              within_node(tag) do
                if block_given?
                  yield
                else
                  text(args.first)
                end
              end

              append_node(tag)
            end
          RUBY
        end
      end
    end

    def text(text)
      append_node(Text.new(self, text))
    end

    tag :area, :base, :br, :col, :embed, :hr, :img, :input, :link, :meta, :param

    content_tag :a, :abbr, :address, :article, :aside, :audio, :b, :bdi, :bdo, :big, :blockquote, :body, :button,
                :canvas, :caption, :cite, :code, :colgroup, :command, :datalist, :dd, :del, :details, :dfn, :div, :dl,
                :dt, :em, :fieldset, :figcaption, :figure, :footer, :form, :h1, :h2, :h3, :h4, :h5, :h6, :head, :header,
                :hgroup, :html, :i, :iframe, :ins, :kbd, :keygen, :label, :legend, :li, :map, :mark, :meter, :nav,
                :noscript, :object, :ol, :optgroup, :option, :output, :p, :pre, :progress, :q, :rp, :rt, :ruby, :s,
                :samp, :script, :section, :select, :small, :source, :span, :strike, :strong, :style, :sub, :summary,
                :sup, :table, :tbody, :td, :textarea, :tfoot, :th, :thead, :time, :title, :tr, :track, :tt, :u, :ul,
                :var, :video, :wbr
  end
end