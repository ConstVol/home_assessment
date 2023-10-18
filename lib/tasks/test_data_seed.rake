# lib/tasks/test_data_seed.rake

namespace :db do
  desc 'Seed the entire database with predefined data'
  task seed_all: [:create_doctors_seed, :create_users_seed, :create_working_hours_seed]

  desc 'Seed the doctors table with predefined data'
  task create_doctors_seed: :environment do

    doctors_data = [
      { name: 'Dr. John Smith', specialization: 'Cardiologist' },
      { name: 'Dr. Jane Doe', specialization: 'Pediatrician' },
      { name: 'Dr. David Johnson', specialization: 'Dermatologist' }
    ]

    doctors_data.each do |doctor_data|
      Doctor.create(doctor_data)
    end

    puts 'Doctors seed data created!'
  end

  desc 'Seed the users table with predefined data'
  task create_users_seed: :environment do
    # Predefined users data
    users_data = [
      { name: 'Smith John' },
      { name: 'Doe Jane' },
      { name: 'Johnson David' }
    ]

    users_data.each do |user_data|
      User.create(user_data)
    end

    puts 'Users seed data created!'
  end

  desc 'Seed the working hours for each doctor'
  task create_working_hours_seed: :environment do

    working_hours_data = [
      { doctor_name: 'Dr. John Smith', start_time: '9:00', end_time: '17:00' },
      { doctor_name: 'Dr. Jane Doe', start_time: '08:30', end_time: '16:30' },
      { doctor_name: 'Dr. David Johnson', start_time: '10:00', end_time: '18:00' }
    ]

    working_hours_data.each do |data|
      doctor = Doctor.find_by(name: data[:doctor_name])

      WorkingHour.create(
        doctor: doctor,
        start_time: data[:start_time],
        end_time: data[:end_time]
      )
    end

    puts 'Working hours seed data created!'
  end
end
