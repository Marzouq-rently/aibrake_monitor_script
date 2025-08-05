# aibrake_monitor_script
To fetch the airbrake from the api and convert it into CSV and store it

## To run this program, you must follow these steps:
### Aibrake user token:
  1. You must have airbake access.
  2. Navigate to your profile
  3. Copy the auth token present there
<img width="1317" height="859" alt="image" src="https://github.com/user-attachments/assets/8de02e77-ac0b-42f8-890a-6e533e2a3996" />
  4. Add it to file in the place near the bearer ->
``` request['Authorization'] = 'Bearer your_token_here' ```

### To get the Result
  1. Navigate to the directory
  2. Run the command: ruby airbrake_monitor.rb
  3. A new CSV file will be stored in your local
