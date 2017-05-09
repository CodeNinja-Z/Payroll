feature 'Uploading a CSV file' do
  scenario 'on success' do
    visit root_path

    file_path = Rails.root.join('spec/fixtures/sample.csv')
    attach_file('file', file_path)

    click_button 'Upload'

    expect(Report.count).to eq 1
    expect(PayStub.count).to eq 14
  end

  scenario "file missing on upload" do
    visit root_path

    click_button "Upload"

    expect(page).to have_content('File Missing!')
    expect(page.current_path).to eq root_path
  end

  scenario 'on failure' do
    visit root_path

    file_1_path = Rails.root.join('spec/fixtures/sample.csv')
    file_2_path = Rails.root.join('spec/fixtures/sample_copy.csv')

    attach_file('file', file_1_path)
    click_button 'Upload'
    expect(Report.count).to eq 1

    attach_file('file', file_2_path)
    expect {
      click_button 'Upload'
    }.not_to change { Report.count }
  end
end
