require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) {
    { name: 'Task 1', description: 'Task 1 description', due_date: Date.today, difficulty: 'low', estimate: 10}
  }

  let(:invalid_attributes) {
    { name: '', description: '', due_date: nil, difficulty: 'low', estimate: 0}
  }

  describe "Get response from sucessfuly created task" do
    it "returns a success response" do
      Task.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "Get response from sucessfuly display details" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :show, params: { id: task.to_param }
      expect(response).to be_successful
    end
  end

  describe "Get response from new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET response from edit" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :edit, params: { id: task.to_param }
      expect(response).to be_successful
    end
  end

  describe "is able to create task" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks list" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid params" do
        it "returns a success response" do
            post :create, params: { task: invalid_attributes }
            expect(response).to be_successful
        end
    end
  end

  describe "is able to update an existing task" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Task 2', description: 'Task 2 description', due_date: Date.tomorrow }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        put :update, params: { id: task.to_param, task: new_attributes }
        task.reload
        expect(task.name).to eq('Task 2')
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, params: { id: task.to_param, task: new_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (to display the 'edit' template)" do
        task = Task.create! valid_attributes
        put :update, params: { id: task.to_param, task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "Delete" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :manual_delete, params: { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :manual_delete, params: { id: task.to_param }
      expect(response).to redirect_to(tasks_path)
    end
  end
end
