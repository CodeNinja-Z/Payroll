class CreatePayStubs < ActiveRecord::Migration[5.0]
  def change
    create_table :pay_stubs do |t|
      t.integer :employee_id
      t.date :pay_period_start_date
      t.date :pay_period_end_date
      t.decimal :amount_paid

      t.timestamps
    end
  end
end
