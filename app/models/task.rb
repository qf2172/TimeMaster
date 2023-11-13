class Task < ApplicationRecord
    attr_accessor :unschedulable
    validates :name, presence: true
    validates :description, presence: true
    enum difficulty: { low: 1, medium: 2, high: 3, urgent: 4 }
    validates :estimate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: false

    # Callback to set duration before validation (so it is set when the task is created or updated)
    before_validation :set_duration
    #before_validation :calculate_start_time
    before_validation do
        calculate_start_time(5)
    end

    # Private method to calculate and set the duration
    def set_duration
        difficulty_value = Task.difficulties[self.difficulty] || 0
  
        # if self.estimate.nil?
        #     raise 'Estimate cannot be nil' # or handle it as per your application's requirement
        # end

        self.duration = 2 * difficulty_value + self.estimate
    end

    # Scope to get tasks in the order they should be started
    scope :ordered_by_duration, -> { order(duration: :desc) }

      # Calculate start time within working hours
    # def calculate_start_time(work_hours_per_day)
    #     # Sort tasks by priority and due date
    #     tasks = Task.ordered_by_duration.to_a

    #     # Define working hours
    #     workday_start_hour = 9 # Example: workday starts at 9 AM
    #     workday_end_hour = workday_start_hour + work_hours_per_day # Calculate end hour based on workday start

    #     tasks.each do |task|
            
    #         # Assume we start considering tasks from the beginning of the next workday
    #         current_time = Time.current.change(hour: workday_start_hour)

    #         # If current time is past work hours, move to next day's work start
    #         if current_time.hour >= workday_end_hour || current_time.hour < workday_start_hour
    #             current_time = current_time.tomorrow.change(hour: workday_start_hour)
    #         end

    #         # Calculate the start time for the task
    #         start_time = task.due_date - (task.duration || 0).hours

    #         # If start time is outside of work hours, adjust it
    #         if start_time.hour > workday_end_hour || start_time.hour < workday_start_hour
    #             start_time = start_time.change(hour: workday_end_hour) - 1.day
    #         end

    #         # If the calculated start time is in the past, adjust to the next available time slot
    #         if start_time < current_time
    #             start_time = current_time
    #         end

    #         # Save the calculated start time in an attribute
    #         self.start_time = start_time

    #         # Update the current time to the end of this task
    #         current_time = start_time + (task.duration || 0).hours

    #         # Move to next day if current time is past work hours
    #         if current_time.hour > workday_end_hour
    #             current_time = current_time.tomorrow.change(hour: workday_start_hour)
    #         end

    #         # # Save the changes (if you decide to persist the start time)
    #         # task.save
    #     end

    #     # Return the task with its calculated start time
    #     # self
    # end


    # ###########感觉ok
    def calculate_start_time(work_hours_per_day)
        return if due_date.nil?
        workday_start_hour = 9 
        workday_end_hour = 14
    
        current_time = Time.current
        days_before_due_to_start = (duration / (workday_end_hour - workday_start_hour)).ceil
        start_time = due_date - days_before_due_to_start
    
        # no time to finish????????
        if start_time < current_time
            # start_time = nil
            start_time = current_time
        end
    
        # Save the calculated start time in an attribute
        self.start_time = start_time
      end

    def unschedulable?
        self.start_time.nil?
    end
    
end
  

# class Task < ApplicationRecord
#     validates :name, presence: true
#     validates :description, presence: true
#     enum difficulty: { low: 1, medium: 2, high: 3, urgent: 4 }
#     validates :estimate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: false

#     # Callback to set duration before validation (so it is set when the task is created or updated)
#     before_validation :set_duration
#     before_validation do
#         calculate_start_time(5)
#     end

#     # Private method to calculate and set the duration
#     def set_duration
#         # Assuming 'difficulty' is stored as an integer corresponding to the enum values
#         self.duration = 2 * Task.difficulties[self.difficulty] + self.estimate
#     end

#     # Scope to get tasks in the order they should be started
#     scope :ordered_by_duration, -> { order(duration: :desc) }

#       # Calculate start time within working hours
#     def calculate_start_time(work_hours_per_day)
#         # Sort tasks by priority and due date
#         tasks = Task.ordered_by_duration.to_a

#         # Define working hours
#         workday_start_hour = 9 # Example: workday starts at 9 AM
#         workday_end_hour = workday_start_hour + work_hours_per_day # Calculate end hour based on workday start

#         tasks.each do |task|
            
#             # Assume we start considering tasks from the beginning of the next workday
#             current_time = Time.current.change(hour: workday_start_hour)

#             # If current time is past work hours, move to next day's work start
#             if current_time.hour >= workday_end_hour || current_time.hour < workday_start_hour
#                 current_time = current_time.tomorrow.change(hour: workday_start_hour)
#             end

#             # Calculate the start time for the task
#             start_time = task.due_date - (task.duration || 0).hours

#             # If start time is outside of work hours, adjust it
#             if start_time.hour > workday_end_hour || start_time.hour < workday_start_hour
#                 start_time = start_time.change(hour: workday_end_hour) - 1.day
#             end

#             # If the calculated start time is in the past, adjust to the next available time slot
#             if start_time < current_time
#                 start_time = current_time
#             end

#             # Save the calculated start time in an attribute
#             self.start_time = start_time

#             # Update the current time to the end of this task
#             current_time = start_time + (task.duration || 0).hours

#             # Move to next day if current time is past work hours
#             if current_time.hour > workday_end_hour
#                 current_time = current_time.tomorrow.change(hour: workday_start_hour)
#             end

#             # # Save the changes (if you decide to persist the start time)
#             # task.save
#         end

#         # Return the task with its calculated start time
#         self
#     end
# end
  