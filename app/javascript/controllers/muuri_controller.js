import { Controller } from '@hotwired/stimulus';
const columnGrids = [];

export default class extends Controller {
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

                    // re enable clickable elements
                    item.getElement().querySelectorAll('.to-disable-btn').forEach((element) => {
                        element.style.pointerEvents = 'auto';
                    });

                    const task = item.getElement().id;
                    const boardId = item.getGrid().getElement().id.split('-')[1];
                    const taskId = task.split('-')[3];
                    const itemPosition = item.getGrid().getItem(item.getElement()).getPosition();
                    const newPosition = calculatePos(itemPosition.top);
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

        function calculatePos(pos) {
            return Math.ceil(pos / 48);
        }
    }

    addTask(event) {
        const boardId = event.currentTarget.dataset.boardId;
        const taskName = prompt("Enter task name to add to board No. " + boardId);
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
                })
                .catch((error) => {
                    console.error("Error saving task to database:", error);
                });
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
        // <div class="icons bg-background p-2">
        //     <%= image_tag "clock.svg", class: "to-disable-btn icon-task" %>
        //     <%= image_tag "label.svg", class: "to-disable-btn icon-task" %>
        //     <%= image_tag "user.svg", class: "to-disable-btn icon-task" %>
        //     <%= image_tag "infos.svg", class: "to-disable-btn icon-task" %>
        // </div>

        // .icons {
        	// visibility: hidden;
        	// position: absolute;
        	// top: 50%;
        	// right: 10px;
        	// transform: translateY(-50%);
        	// display: flex;
        	// gap: 10px;
        	// z-index: 1;
        // }
        // 
        // .task-container:hover .icons {
        	// visibility: visible;
        // }
        const clockIcon = document.createElement("img");
        clockIcon.src = "/assets/clock.svg";
        clockIcon.classList.add("to-disable-btn", "icon-task");
        iconsContainer.appendChild(clockIcon);

        const labelIcon = document.createElement("img");
        labelIcon.src = "/assets/label.svg";
        labelIcon.classList.add("to-disable-btn", "icon-task");
        iconsContainer.appendChild(labelIcon);

        const userIcon = document.createElement("img");
        userIcon.src = "/assets/user.svg";
        userIcon.classList.add("to-disable-btn", "icon-task");
        iconsContainer.appendChild(userIcon);

        const infosIcon = document.createElement("img");
        infosIcon.src = "/assets/infos.svg";
        infosIcon.classList.add("to-disable-btn", "icon-task");
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