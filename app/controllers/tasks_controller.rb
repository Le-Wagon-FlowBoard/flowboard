class TasksController < ApplicationController
	def index
		@tasks = Task.all
	end

	def show

		@task = Task.find_by_id(params[:id])
	end

	def new

		@task = Task.new
	end

  def add_labels_to_task
    @task = Task.find(params[:task_id])  # Récupérer la tâche en fonction de l'ID
    label_ids = params[:label_ids]  # Récupérer les IDs des labels sélectionnés depuis la requête AJAX

    # Ajouter les labels à la tâche
    @task.labels << Label.where(id: label_ids)

    # Répondre à la requête AJAX avec un statut HTTP approprié
    respond_to do |format|
      format.json { render json: { message: 'Labels ajoutés avec succès à la tâche' } }
    end
  end


	def create
		@task = Task.create(name: params[:task_name], board_id: params[:board_id])
		if @task.save
			render json: @task
		else
			render json: { status: @task.errors.full_messages }
		end
	end

	def edit
		@task = Task.find_by_id(params[:id])
	end

	def update
    @task = Task.find_by_id(params[:task_id])  # Use 'params[:id]' instead of 'params[:task_id]'

    if @task.update(task_params)
      render json: { status: 'Task updated successfully' }
    else
      render json: { status: @task.errors.full_messages }
    end
  end

	def destroy
		@task = Task.find_by_id(params[:id])
		@task.destroy
		redirect_to tasks_path
	end

	private

	def task_params
    params.require(:task).permit(:project_id, :board_id, :position, :task_id, :task_name)
  end
end
