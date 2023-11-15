Given /the following tasks exist/ do |task_table|
    task_table.hashes.each do |task|
      Task.create(task)
    end
  end

Given("I am on the tasks page") do
    visit tasks_path
  end
  
Given("I have added a task with name {string}, description {string}, due date {string}, and estimate {string}") do |name, description, due_date, estimate|
    Task.create!(name: name, description: description, due_date: Date.parse(due_date), estimate: estimate)
end  

When('I create a new task with name {string}, description {string}, due date {string}, and estimate {string}') do |string, string2, string3, string4|
    visit new_task_path
    fill_in "Name", with: string
    fill_in "Description", with: string2
    fill_in "Due date", with: string3
    fill_in "Estimate", with: string4
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
  

When('I click the {string}') do |button_text|
    click_link(button_text)
  end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    expect(page.body.index(e1)).to be < page.body.index(e2)
end



Given('I am on the new task page') do
    visit new_task_path
  end
  
  When('I submit invalid task information') do
    fill_in 'Name', with: '' 
    click_button 'Create Task'
  end
  
  Then('I should see an error message {string}') do |arg1|
    expect(page).to have_content(arg1 + " can't be blank")
  end
  
  And('I should be on the new task page again') do
    expect(current_path).to eq tasks_path
  end


  Given('I am on the edit task page for task with id {string}') do |id|
    visit edit_task_path(id)
  end
  
  When('I submit invalid information for the task') do
    fill_in 'Description', with: ''
    click_button 'Update Task'
  end
  
  
  And('I should be on the edit task page for task with id {string}') do |id|
    expect(current_path).to eq "/tasks/1"
  end
  
