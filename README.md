# Application Build & Set Up
The applicaion is built with Rails 5.0.2, with Postgresql used as database.
Run the following steps to build it locally and set up the local server
1. bundle install
2. rails s
3. rspec (to run the test suites)
4. A file named 'sample.csv' is attached at the root directory of the app. It can be used for uploading.

# Some Things To Be Proud Of
When working on this coding challenge, I focused more on the back-end performance. 
1. Database structure design. Though this is a simple application to import and convert uploaded .csv files. I do my best to optimize its performance, starting from the database storage. 
  * When uploading .csv files, I calculate the amount of salary based on the data read from the file and then save the data into report tables and pay stub tables separately.
  * Report table only stores the report_id to determine if a report with same report_id was uploaded. 
  * Each pay stub record will be created if the employee_id and pay_period are both not existed, and later if a new record (row in .csv file) has the same employee_id and within the same pay period, the amount_paid will be calculated and the existing pay stub record will be updated. So there will be no new record created.
  * With such implementation, the amount of database records is reduced and the size of database is reduced as well. The speed increases when making query from controller.
  
2. All model methods, controller actions, helper methods and features are tested with RSpec and Capybara. The quality of code is ensured.

The front-end UI is not too fancy but intuitive, concise and easy to use.

# Models & Controllers
1. Report model/controller are in charge of importing the .csv files, doing calculations before saving the data into reports table and pay_stubs table.
2. Pay stub model's attributes are delegated to report model using attr_accessor when createing pay stub records inside the 'upload' method in report model.

# Notes
Comments are added at the necessary places in the code like at critical steps in model method for readability.
