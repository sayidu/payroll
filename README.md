# README

Hi Wave Team, 

Thank you for taking the time to review my submission. 
Here's a quick guide on how to run this application: 

### Local Machine
* Installation Prerequisites: `ruby: 3.2.0` and `rails 7`.
* Run: `bundle install`
* Start App: `rails server`

However, to test with ease: 
* The application is hosted at: https://payroll-design-06d15c5e3dcc.herokuapp.com
* You can visit the site to test the functionality.

### Personal Review

How did you test that your implementation was correct?
```
This application was tested using specs. 
The bulk of the logic is in services that can be easily tested.
```

If this application was destined for a production environment, what would you add or change?
```
* Architecture: Using SPA (ie. React) For Frontend and Rails for only API.
* Uploads: Leverage a Bulk Import Strategy to import the timesheet data into the application.
* Reports: Cron Job to generate jobs for most recent pay periods, persist in file storage. 
           This will reduce the resources required to provide the reports.
* Code Improvements: 
  - More Specs for Model/Controller
  - Abstract CSS
```

What compromises did you have to make as a result of the time constraints of this challenge?
```
Main compromise:
* Using rails to fully achieve the solution. 
* Focusing on having an MVP approach for the development.
* No CI/CD on github to display specs are actually running.
```
