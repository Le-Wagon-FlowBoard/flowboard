// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import muuri_controller from "./muuri_controller"
window.Stimulus.register("muuri", muuri_controller)