require 'active_support/core_ext/module/delegation'
require 'tallulah'

class FormFor < Tallulah::HTML::FORM
  class Label
  end

  class InputField
    def initialize(parent, object, attribute)
      @object, @attr = object, attribute
      super(parent)
      input name: "#{param_key}[#{attribute}]", type: "text", value: value
    end
  end

  class InputGroup < Tallulah::Component
    include Tallulah::HTML

    def initialize(parent, object, attribute)
      @object, @attr = object, attribute
      super(parent, &nil)
      input_tag(name: "#{param_key}[#{attribute}]", type: "text", value: value)
    end

    def param_key
      @object.model_name.param_key
    end

    def value
      @object.send(@attr)
    end
  end

  register_component :form_for

  def initialize(parent, object, opts = {}, &block)
    @object = object
    super(parent, opts, &block)
  end

  def input(attr)
    append_node(InputGroup.new(parent, @object, attr))
  end
end

class Panel < Tallulah::HTML::DIV
  register_component :panel

  def body(&block)
    div_tag(class: "panel-body", &block)
  end

  private

  def default_attributes
    {class: "panel panel-default"}
  end
end

class Btn < Tallulah::HTML::A
  register_component :btn

  def initialize(parent, caption, href, attrs = default_attributes, &block)
    @href = href
    super(parent, attrs, &block)
  end

  def default_attributes
    {class: "btn", href: @href}
  end
end

class View
  include Tallulah::Context
  include Tallulah::HTML

  def initialize(&block)
    @children = []
    instance_eval(&block)
  end
end

object = Class.new do
  attr_accessor :title, :created_at

  def initialize(title, created_at = Time.now)
    @title, @created_at = title, created_at
  end

  def model_name
    @model_name ||= Class.new do
      def self.param_key
        "post"
      end
    end
  end
end.new("Hello World")

view = View.new do
  html_tag do
    body_tag do
      btn "LOOOL", "#lool"

      panel do
        body do
          form_for(object) do |f|
            div_tag class: "form-control" do
              f.input :title
            end
          end
        end
      end
    end
  end
end

puts view.to_html
