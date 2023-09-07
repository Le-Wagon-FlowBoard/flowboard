import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat"
export default class extends Controller {
  static values = { projectId: Number, userId: Number }
  static targets = ["messages", "input"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ProjectChannel", project_id: this.projectIdValue },
      {
        received: (data) => {
          fetch(`/message?message_id=${data.data.id}&user_id=${this.userIdValue}`)
            .then((response) => response.text())
            .then((html) => {
              this.messagesTarget.insertAdjacentHTML("beforeend", html)
              this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
            })
        },
      }
    )
    let offcanvasBody = document.querySelector(".offcanvas-body")
    offcanvasBody.scrollTop = offcanvasBody.scrollHeight
  }

  send() {
      if (this.inputTarget.value === "") {
        return
      }
      let csrfToken = document.querySelector('meta[name="csrf-token"]').content
      fetch(`/projects/${this.projectIdValue}/messages`, {
        method: "POST",
        headers: {
          "X-CSRF-Token": csrfToken,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ 
          content: this.inputTarget.value,
          project_id: this.projectIdValue,
          user_id: this.userIdValue
        }),
      })
      this.channel.send({ content: this.inputTarget.value })
      this.inputTarget.value = ""
  }

  sendEnter(event) {
    if (event.key === "Enter") {
      this.send(event)
    }
  }
}
