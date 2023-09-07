import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popovers"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    new bootstrap.Popover(this.element)
  }
}
