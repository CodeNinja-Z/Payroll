RSpec.describe Report, type: :model do
  describe '.upload' do
    it 'successfully create a report and pay stub objects' do
      # Ref to create a test csv file under test environment: 
      # https://collectiveidea.com/blog/archives/2017/01/16/testing-an-uploaded-file-in-rspec
      csv = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.csv'))
      Report.upload(csv)
      expect(Report.first.report_id).to eq 43
      expect(Report.first).to be_valid
      expect(PayStub.count).to eq 14
    end
  end
end
