# class TasksController < ApplicationController
#   before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :manual_delete]

#   # Get all tasks
#   def index
#     sort_column = params[:sort] || 'name'
#     sort_direction = params[:direction] || 'asc'

#     sort_column = 'name' unless Task.column_names.include?(sort_column)
#     sort_direction = 'asc' unless %w[asc desc].include?(sort_direction)

#     @tasks = Task.all.order(sort_column + ' ' + sort_direction)
#   end


#   # Show form for a new task
#   def new
#     @task = Task.new
#   end

#   # Create a new task
#   def create
#     @task = Task.new(task_params)
#     if @task.save      
#         redirect_to tasks_path, notice: 'Task was successfully created.'
#     else
#       flash.now[:alert] = @task.errors.full_messages.to_sentence
#       render :new
#     end
#   end


#   #Show a single task
#   def show
#     @task = Task.find(params[:id])
#   end

#   # Show form for editing a task
#   def edit
#     @task = Task.find(params[:id])
#   end

#   # Update a task
#   def update
#        @task = Task.find(params[:id])
#     if @task.update(task_params)
#       # @task.calculate_start_time(5)
#       redirect_to tasks_path, notice: 'Task was successfully updated.'
#     else
#       flash.now[:alert] = @task.errors.full_messages.to_sentence
#       render :edit
#     end
#   end


#   def manual_delete
#     @task = Task.find(params[:id])
#     @task.destroy
#     redirect_to tasks_path, notice: 'Task was successfully deleted.'
#   end
#   # Delete a task
#   # def destroy
#   #   @task = Task.find(params[:id])
#   #   @task.destroy
#   #   redirect_to tasks_path, notice: 'Task was successfully deleted.'
#   # end    

#   private
#   # Define strong parameters for the Task model
#   def task_params
#     params.require(:task).permit(:name, :description, :due_date, :difficulty, :estimate)
#   end
  
# end
class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :manual_delete]

  # Get all tasks
  def index
      sort_column = params[:sort] || 'name'
      sort_direction = params[:direction] || 'asc'
    
      sort_column = 'name' unless Task.column_names.include?(sort_column)
      sort_direction = 'asc' unless %w[asc desc].include?(sort_direction)
    
      @tasks = current_user.tasks.order("#{sort_column} #{sort_direction}")
  end


  def new
      @task = current_user.tasks.build
  end
  
  # Create a new task
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :new
    end
  end


  #Show a single task
  def show
    @task = current_user.tasks.find(params[:id])
  end

  # Show form for editing a task
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # Update a task
  def update
       @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      # @task.calculate_start_time(5)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end


  def manual_delete
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end 

  private

def task_params
  params.require(:task).permit(:name, :description, :due_date, :difficulty, :estimate)
end

def logged_in_user
  redirect_to login_url unless current_user
end

def authenticate_user
  redirect_to login_path, alert: "You must be logged in to access this page." if current_user.nil?
end
  
end
