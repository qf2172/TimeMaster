Given /the following tasks exist/ do |task_table|
    task_table.hashes.each do |task|
      Task.create(task)
    end
  end

Given("I am on the tasks page") do
    visit tasks_path
  end
  
  Given("I have added a task with name {string}, description {string}, and due date {string}") do |name, description, due_date|
    Task.create!(name: name, description: description, due_date: Date.parse(due_date))
  end  
  
  When("I create a new task with name {string}, description {string}, and due date {string}") do |name, description, due_date|
    visit new_task_path
    fill_in "Name", with: name
    fill_in "Description", with: description
    fill_in "Due date", with: due_date
    click_button "Create Task"
  end
  
  When("I edit {string} to change its name to {string}") do |old_name, new_name|
    task = Task.find_by(name: old_name)
    visit edit_task_path(task)
  
    fill_in 'Name', with: new_name
    click_button 'Update Task'
  end
  
  


  When("I delete the task named {string}") do |task_name|
    within("table") do
      find('tr', text: task_name).click_link('Delete')
    end
  end
  
  
  When("I view the details of the task named {string}") do |task_name|
    within("table") do
      find('tr', text: task_name).click_link('Show')
    end
  end
  
  Then("I should see {string} in the tasks list") do |name|
    expect(page).to have_content(name)
  end
  
  Then("I should not see {string} in the tasks list") do |name|
    expect(page).not_to have_content(name)
  end
  
  Then("I should see details for {string}") do |name|
    expect(page).to have_content(name)
  end
  