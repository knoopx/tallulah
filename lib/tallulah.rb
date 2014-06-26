module Tallulah
  autoload :ActionView, "tallulah/action_view"
  autoload :Component, "tallulah/component"
  autoload :ContentTag, "tallulah/content_tag"
  autoload :Context, "tallulah/context"
  autoload :HTML, "tallulah/html"
  autoload :Node, "tallulah/node"
  autoload :Tag, "tallulah/tag"
  autoload :Text, "tallulah/text"
  autoload :VERSION, "tallulah/version"

  require 'tallulah/railtie' if defined?(Rails)
end
