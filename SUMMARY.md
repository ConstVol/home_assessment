# Thoughts Process
1. Data modals
   - Come up with the minimal required number of data models and attributes to cover the required functionality.
   - Draw relations between them.
2. The fundamental of availability will be calculated from doctor's working hours.
3. We have a standard working hours without complexity in week days or breaks during the day, vacations.
By default I use hardcoded one hour appointment duration for all doctors 
(which in real application I wouldn't use but for making it more simple I used an hour limit for an appointment).


* For demonstration of working hours I added serializer that converts military hours to PM/AM format.
* Added statuses (booked and canceled).
  * For open slots I added validators to make sure data exists and that is it in future (for booked statuses) and validation that time slot is available.
* In terms of appointment update endpoint a doctor or a user can be updated.
* The endpoint for deleting appointment doesn't delete a record, instead it updates booked status to canceled .
*  View doctors availability endpoint by default provides doctor's availability for current date (available working hours in future).
  * This endpoint can be used with query params (start date AND/OR end date): 
    * Doctor's availability is calculated in terms of his working hours with one hour interval excluding already booked appointments. 
    * Validator is added to controller so that to validate query params (that dates are >= current date, and end date > start date).


  * Swagger is added with endpoints description.
  * Seeds were added for testing purposes to fill in data base with users, doctors and working hours.
  

# Data Models

The project uses four primary data models:

* Doctor
  - Attributes:
    - id (Primary Key)
    - name
    - specialization
  - Associations:
    - Has one WorkingHour records.
    - Has many Appointment records.
* WorkingHour
  - Attributes:
    - id (Primary Key)
    - doctor_id (Foreign Key to Doctor)
    - start_time
    - end_time
  - Associations:
    - Belongs to a Doctor.
 * Appointment
   - Attributes:
     - id (Primary Key)
     - doctor_id (Foreign Key to Doctor)
     - user_id (Foreign Key to User)
     - date
     - status
   - Associations:
     - Belongs to a Doctor.
     - Belongs to a User.
* Users
  - Attributes:
      - id (Primary Key)
      - name
      - Associations:
          - Has many Appointment records.