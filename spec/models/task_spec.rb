require "rails_helper"
FactoryBot.define do
    factory :task do
      name { 'Default Task Name' }
      description { 'Default Task Description' }
    end
end

RSpec.describe Task, type: :model do
    describe 'validations' do
      let(:task1) { FactoryBot.create(:task, name: 'Task 1', description: 'Description 1') }
      let(:task2) { FactoryBot.build(:task, name: nil, description: 'Description 2') } 
      let(:task3) { FactoryBot.build(:task, name: 'Task 3', description: nil) } 
  
      it 'is valid with valid attributes' do
        expect(task1).to be_valid
      end
  
      it 'is not valid without a name' do
        expect(task2).not_to be_valid
        expect(task2.errors[:name]).to include("can't be blank")
      end
  
      it 'is not valid without a description' do
        expect(task3).not_to be_valid
        expect(task3.errors[:description]).to include("can't be blank")
      end
    end
end