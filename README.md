# airbrake_monitor_script
To fetch the airbrake errors from the api and convert it into CSV and store it

## To run this program, you must follow these steps:
### Aibrake user token:
  1. You must have airbake access.
  2. Navigate to your profile
  3. Copy the auth token present there
<img width="1317" height="859" alt="image" src="https://github.com/user-attachments/assets/8de02e77-ac0b-42f8-890a-6e533e2a3996" />

### To get the Result
  1. Navigate to the directory in the terminal
  2. Run the command: 

  <pre>
    # in the place of token add the token you copied with the quotes like 'dyvqregqer'
    
    ruby airbrake_monitor.rb token
  </pre>

  3. A new CSV file will be stored in your local
  4. By default it will get the Rently Aura-qe env error results, the searching term with the authorize net errors and the time as day before yesterday

> **ℹ️ Info:** For now We are passing the token as arguments while running the script. In future will update by calling the token api internally and if needed we will add the email and password as arguments in the command.

### Passing Arguments in the command
  1. We can pass the project id while running the command to get the airbrake result of different environments. The command will look like:

  <pre>
    # the project id contains the id. If you do not want to pass the project id while passing arguments just put nil

    ruby airbrake_monitor.rb token project_id
  </pre>

  2. We can pass the search filters as well:

  <pre>
    # the search_term should look like:
    # lets say you want to filter with terms 'undefinded' and 'match'
    # the search term should look like '["undefined", "match"]'
    # it is important to pass that array inside the single quotes
    # If you do not want to pass the project id while passing arguments just put ''

    ruby airbrake_monitor.rb token project_id search_terms
  </pre>

  3. We can pass the time after which the error was last created

  <pre>
    # The start_time should look like '2025-08-01'

    ruby airbrake_monitor.rb token project_id search_terms start_time
  </pre>
