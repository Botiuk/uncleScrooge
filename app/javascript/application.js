// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import "./controllers"
import "./custom/alpine-min"
import "activestorage"
import "trix"
import "@rails/actiontext"
