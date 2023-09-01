import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-board"
export default class extends Controller {

  static targets = ["board", "description"]
  connect() {

    console.log("edit board controller connected")
  }
}
