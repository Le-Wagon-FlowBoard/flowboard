import { Controller } from '@hotwired/stimulus';
const columnGrids = [];

export default class extends Controller {

    static targets = ["infos", "form", "card", "input"]

    connect() {
        var dragContainer = document.querySelector('.drag-container');

        // Board Draggables
        // allow boards to be dragged to the left and right
        var boardItemsContainer = [].slice.call(document.querySelector('.board'));
        var boardColumnGrids = [];

        // Tasks draggables
        var itemContainers = [].slice.call(document.querySelectorAll('.board-column-content'));
        var boardGrid;

        itemContainers.forEach(function (container) {
            var grid = new Muuri(container, {
                items: '.board-item',
                dragEnabled: true,
                dragSort: function () {
                    return columnGrids;
                },
                dragStartPredicate: {
                    distance: 0,
                    delay: 100,
                },
                dragContainer: dragContainer,
                dragAutoScroll: {
                    targets: (item) => {
                        return [
                            { element: window, priority: 0 },
                            { element: item.getGrid().getElement().parentNode, priority: 1 },
                        ];
                    }
                },
            })
                .on('dragInit', function (item) {
                    item.getElement().style.width = item.getWidth() + 'px';
                    item.getElement().style.height = item.getHeight() + 'px';
                    // any element with class to-disable-btn inside the task will not be clickable while dragging
                    item.getElement().querySelectorAll('.to-disable-btn').forEach((element) => {
                        element.style.pointerEvents = 'none';
                    });
                })
                .on('dragReleaseEnd', function (item) {
                    item.getGrid().refreshItems([item]);
                    item.getGrid().synchronize();

                    // re enable clickable elements
                    item.getElement().querySelectorAll('.to-disable-btn').forEach((element) => {
                        element.style.pointerEvents = 'auto';
                    });

                    const task = item.getElement().id;
                    const boardId = item.getGrid().getElement().id.split('-')[1];
                    const taskId = task.split('-')[3];
                    const newPosition = calculatePos(item.getGrid().getElement(), item.getElement());
                    const project_id = Number(window.location.pathname.split('/')[2]);
                    let csrfToken = document.querySelector('meta[name="csrf-token"]').content;
                    fetch(`/projects/${project_id}/boards/${boardId}/tasks/${taskId}`, {
                        method: 'PATCH',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-Token': csrfToken
                        },
                        body: JSON.stringify({
                            board_id: Number(boardId),
                            task_id: Number(taskId),
                            project_id: project_id,
                            position: newPosition + 1
                        })
                    })
                })
                .on('layoutStart', function () {
                    boardGrid.refreshItems().layout();
                });

            columnGrids.push(grid);
        });

        // Init board grid so we can drag those columns around.
        boardGrid = new Muuri('.board', {
            dragEnabled: true,
            dragHandle: '.board-column-header'
        });

        function calculatePos(parent, item) {
            let children = parent.children;
            let itemIndex = Array.prototype.indexOf.call(children, item);
            return itemIndex;
        }
    }

    showForm(event) {
        let boardId = event.target.id.split("-")[2]
        event.preventDefault();
        document.getElementById(`add-task-${boardId}`).classList.add("d-none");
        document.getElementById(`form-task-${boardId}`).classList.remove("d-none");
        document.getElementById(`form-task-${boardId}`).focus();
    }

    addTask(event) {
        event.preventDefault();

        if (event.key === "Enter") {
          const boardId = event.currentTarget.dataset.boardId;
          const taskName = document.getElementById(`form-task-${boardId}`).value;
          if (taskName !== null && taskName.trim() !== "") {
              const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
              fetch(`/projects/${this.projectId}/boards/${boardId}/tasks`, {
                  method: "POST",
                  headers: {
                      "Content-Type": "application/json",
                      "X-CSRF-Token": csrfToken,
                  },
                  body: JSON.stringify({
                      board_id: boardId,
                      task_name: taskName,
                  }),
              })
                  .then((response) => response.json())
                  .then((response) => {
                      this.createTaskElement(boardId, response.id, taskName);
                      document.getElementById(`form-task-${boardId}`).value = "";
                  })
                  .catch((error) => {
                      console.error("Error saving task to database:", error);
                  });
          }
        } else if (event.key === "Escape") {
          const boardId = event.currentTarget.dataset.boardId;
          document.getElementById(`add-task-${boardId}`).classList.remove("d-none");
          document.getElementById(`form-task-${boardId}`).classList.add("d-none");
          document.getElementById(`form-task-${boardId}`).value = "";
        }
    }

    createTaskElement(boardId, taskId, taskName) {
        const taskElement = document.createElement("div");
        taskElement.classList.add("board-item");
        taskElement.id = `board-${boardId}-task-${taskId}`;

        const taskContainer = document.createElement("div");
        taskContainer.classList.add(
            "task-container",
            "bg-background",
            "py-2",
            "px-3",
            "rounded-2",
            "mt-2",
            "hover-pointer",
            "d-flex",
            "justify-content-between",
            "align-items-center",
            "w-100"
        );

        const taskNameElement = document.createElement("div");
        taskNameElement.classList.add(
            "text-light-grey",
            "fs-6",
            "mb-0",
            "overflow-hidden",
            "flex-grow-1"
        );
        taskNameElement.textContent = taskName;

        const iconsContainer = document.createElement("div");
        iconsContainer.classList.add("icons", "bg-background", "p-2");
        iconsContainer.style.visibility = "hidden";

        const clockIcon = document.createElement("img");
        clockIcon.src = "https://svgshare.com/i/xKJ.svg";
        clockIcon.classList.add("to-disable-btn", "icon-task");
        // add data-bs-toggle="modal" data-bs-target="#addDeadLineModal-#{task.id}" to open the modal
        clockIcon.setAttribute("data-bs-toggle", "modal");
        clockIcon.setAttribute("data-bs-target", `#addDeadLineModal-${taskId}`);
        clockIcon.id = `addDeadLineModalButton`;
        iconsContainer.appendChild(clockIcon);

        const labelIcon = document.createElement("img");
        labelIcon.src = "https://svgshare.com/i/xKV.svg";
        labelIcon.classList.add("to-disable-btn", "icon-task");
        labelIcon.setAttribute("data-bs-toggle", "modal");
        labelIcon.setAttribute("data-bs-target", `#addLabelModal-${taskId}`);
        labelIcon.id = `addLabelModalButton`;
        iconsContainer.appendChild(labelIcon);

        const userIcon = document.createElement("img");
        userIcon.src = "https://svgshare.com/i/xJ2.svg";
        userIcon.classList.add("to-disable-btn", "icon-task");
        userIcon.setAttribute("data-bs-toggle", "modal");
        userIcon.setAttribute("data-bs-target", `#addAssigneeModal-${taskId}`);
        userIcon.id = `addAssigneeModalButton`;
        iconsContainer.appendChild(userIcon);

        const infosIcon = document.createElement("img");
        infosIcon.src = "https://svgshare.com/i/xJ_.svg";
        infosIcon.classList.add("to-disable-btn", "icon-task");
        infosIcon.setAttribute("data-bs-toggle", "modal");
        infosIcon.setAttribute("data-bs-target", `#taskInfosModal-${taskId}`);
        iconsContainer.appendChild(infosIcon);

        taskContainer.addEventListener("mouseenter", () => {
            iconsContainer.style.visibility = "visible";
        });

        taskContainer.addEventListener("mouseleave", () => {
            iconsContainer.style.visibility = "hidden";
        });

        taskContainer.appendChild(taskNameElement);
        taskContainer.appendChild(iconsContainer);
        taskElement.appendChild(taskContainer);

        const grid = columnGrids.find((columnGrid) => {
            return columnGrid.getElement().id === `board-${boardId}`;
        });
        grid.add(taskElement);

        fetch(`/add_label_modal?task_id=${taskId}`)
            .then((response) => response.text())
            .then((response) => {
                const body = document.querySelector("body");
                body.insertAdjacentHTML("beforeend", response);
            })
            .catch((error) => {
                console.error("Error fetching label modal:", error);
            });

        fetch(`/add_deadline_modal?task_id=${taskId}`)
            .then((response) => response.text())
            .then((response) => {
                const body = document.querySelector("body");
                body.insertAdjacentHTML("beforeend", response);
            })
            .catch((error) => {
                console.error("Error fetching deadline modal:", error);
            });
            
        fetch(`/add_assignee_modal?task_id=${taskId}`)
            .then((response) => response.text())
            .then((response) => {
                const body = document.querySelector("body");
                body.insertAdjacentHTML("beforeend", response);
            })
            .catch((error) => {
                console.error("Error fetching assignee modal:", error);
            });

        setTimeout(() => {
            taskElement.scrollIntoView({
                behavior: "smooth",
                block: "end",
                inline: "nearest",
            });
        }, 300);
    }

    get projectId() {
        return Number(window.location.pathname.split("/")[2]);
    }
}
