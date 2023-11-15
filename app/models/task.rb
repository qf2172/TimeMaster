class Task < ApplicationRecord
    attr_accessor :unschedulable
    validates :name, presence: { message: "can't be blank" }
    validates :description, presence: { message: "can't be blank" }
    enum difficulty: { low: 1, medium: 2, high: 3, urgent: 4 }
    validates :estimate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }, presence: true


    # Callback to set duration before validation (so it is set when the task is created or updated)
    before_validation :set_duration
    #before_validation :calculate_start_time
    before_validation do
        calculate_start_time(5)
    end

    # Private method to calculate and set the duration
    def set_duration
        difficulty_value = Task.difficulties[self.difficulty] || 0
  
        self.duration = 2 * difficulty_value + self.estimate
    end

    scope :ordered_by_duration, -> { order(duration: :desc) }

    def calculate_start_time(work_hours_per_day)
        return if due_date.nil?
        workday_start_hour = 9 
        workday_end_hour = 14
    
        current_time = Time.current
        days_before_due_to_start = (duration / (workday_end_hour - workday_start_hour)).ceil
        start_time = due_date - days_before_due_to_start
    
        # no time to finish
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
  
  