class Report < ApplicationRecord
  # For mass assignment
  attr_accessor :employee_id, :pay_period_start_date, :pay_period_end_date, :amount_paid

  # Validations
  validates :report_id, uniqueness: true

  # Class Methods

  # Iteration 1
  # Convert the date range & calculate the amount paid for each pay period
  # before saving them to database for the purpose of reducing database
  # size and the amount of records.

  # Iteration 2
  # Move the upload method to a background job, handling the uploading
  # asynchronously.

  def self.upload(file)
    # Read the uploaded CSV file
    csv = Roo::CSV.new(file.path)
    header = csv.row(1)
    footer = csv.row(csv.last_row)
    report_id = footer[1]

    # Create and save the report info if not exist
    if !exists?(report_id: report_id)
      Report.create! report_id: report_id

      # Iterate the report, extract the data and save in pay stub object
      (2..(csv.last_row - 1)).each do |i|
        row = Hash[[header, csv.row(i)].transpose]

        # Cache variables read from each CSV row
        employee_id = row['employee id'].to_i
        year = row['date'].to_date.year
        month = row['date'].to_date.month
        day = row['date'].to_date.day
        job_group = row['job group'].to_s
        hours_worked = row['hours worked'].to_f

        if day.between?(1, 15)
          pay_period_start_date = "1/#{month}/#{year}".to_date
          pay_period_end_date = "15/#{month}/#{year}".to_date
        else
          last_day = row['date'].to_date.end_of_month.day
          pay_period_start_date = "16/#{month}/#{year}".to_date
          pay_period_end_date = "#{last_day}/#{month}/#{year}".to_date
        end

        # If employee id & date range existing, add up the amount paid
        # and update the existing pay stub record
        pay_stub = PayStub.find_by(employee_id: employee_id, pay_period_start_date: pay_period_start_date, pay_period_end_date: pay_period_end_date)
        
        if pay_stub.present?
          if job_group == 'A'
            pay_stub.amount_paid += 20 * hours_worked
          else
            pay_stub.amount_paid += 30 * hours_worked
          end
        # If employee id & date range not existing, set the amount paid
        # and create a new pay stub record
        else
          pay_stub = PayStub.new
          pay_stub.employee_id = employee_id
          pay_stub.pay_period_start_date = pay_period_start_date
          pay_stub.pay_period_end_date = pay_period_end_date

          if job_group == 'A'
            pay_stub.amount_paid = 20 * hours_worked
          else
            pay_stub.amount_paid = 30 * hours_worked
          end
        end

        # Save the pay stub object
        pay_stub.save!
      end
      
      return true
    else
      return false
    end
  end
end
