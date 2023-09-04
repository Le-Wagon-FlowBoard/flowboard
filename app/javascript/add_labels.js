document.addEventListener("DOMContentLoaded", function() {
  var assignLabelsBtn = document.getElementById("assignLabelsBtn");
  if (assignLabelsBtn) {
    assignLabelsBtn.addEventListener("click", function() {
      var task_id = assignLabelsBtn.getAttribute("data-task-id"); // Récupérez task_id depuis l'attribut data-task-id

      var selectedLabels = Array.from(document.querySelectorAll('input[name="selected_labels[]"]:checked')).map(function(checkbox) {
        return checkbox.value;
      });

      // Envoyez les IDs des labels sélectionnés au serveur via une requête AJAX.
      console.log(selectedLabels);
      var xhr = new XMLHttpRequest();
      xhr.open("POST", '/add_labels_to_task', true);
      xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            // Traitez la réponse du serveur ici si nécessaire.
            // Par exemple, mettez à jour la tâche ou affichez un message de confirmation.
          } else {
            // Traitez les erreurs ici si nécessaire.
          }
          // Fermez la modal après l'assignation des labels.
          var addLabelModal = document.getElementById("addLabelModal");
          if (addLabelModal) {
            addLabelModal.classList.remove("show");
            addLabelModal.style.display = "none";
            document.body.classList.remove("modal-open");
          }
        }
      };

      var data = JSON.stringify({ task_id: task_id, label_ids: selectedLabels });
      xhr.send(data);
    });
  }
});
