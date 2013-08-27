require 'rails/railtie'
require 'action_view/template'

module Tallulah
  class Railtie < Rails::Railtie
    initializer "tallulah.initialize" do
      ::ActionView::Base.class_eval do
        include Tallulah::Context
      end
      ::ActionView::Template.register_template_handler :tall, ActionView::TemplateHandler.new
    end
  end
end