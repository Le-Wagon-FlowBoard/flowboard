import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-board"
export default class extends Controller {

  static targets = ["infos", "form", "card"]
  connect() {

    console.log("edit board controller connected")
    console.log(this.infosTarget)
    console.log(this.formTarget)
  }

  update(event) {
    event.preventDefault()

    if (event.key === "Enter") {
      const url = this.formTarget.action
      fetch(url, {
        method: "PATCH",
        headers: { "Accept": "text/plain" },
        body: new FormData(this.formTarget)
      })
      this.infosTarget.classList.remove("d-none")
      this.formTarget.classList.add("d-none")
      this.infosTarget.innerHTML = event.target.value
      }
  }

  displayForm() {
    this.infosTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }
}
