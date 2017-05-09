class PayStub < ApplicationRecord
  # Validations
  validates :employee_id, :pay_period_start_date, :pay_period_end_date, :amount_paid, presence: true
end
