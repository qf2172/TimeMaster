class TasksController < ApplicationController
  # Get all tasks
  def index
    @task = Task.all
  end

  # Show form for a new task
  def new
    @task = Task.new
  end

  # Create a new task
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end


  #Show a single task
  def show
    @task = Task.find(params[:id])
  end

  # Show form for editing a task
  def edit
    @task = Task.find(params[:id])
  end

  # Update a task
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end


  def manual_delete
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end
  # Delete a task
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end    

  private
  # Define strong parameters for the Task model
  def task_params
    params.require(:task).permit(:name, :description, :due_date)
  end
end
