import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import muuri_controller from "./muuri_controller"
window.Stimulus.register("muuri", muuri_controller)

export { application }
