RSpec.describe PayStub, type: :model do
  describe 'validation' do
    it 'has a valid record' do
      pay_stub = PayStub.create employee_id: 1, pay_period_start_date: '01/05/2017'.to_date, pay_period_end_date: '15/05/2017'.to_date, amount_paid: 140
      expect(pay_stub).to be_valid
    end
  end
end
