RSpec.describe ReportsHelper, type: :helper do
  describe "date format" do
    it "formats date to dd/mm/yyyy" do
      date = '2017-05-01'.to_date
      expect(helper.format_date(date)).to eq('01/05/2017')
    end
  end
end
