require_relative 'class'
require_relative 'appointment'

# Main class
class HospitalManagement
  attr_accessor :patient, :doctor

  def initialize
    @patients = []
    @doctors = []
    @assigned = []
    @appointments = []
  end

  # Method to display menu to user
  def display_menu
    loop do
      puts '********Welcome to Hospital Management System**************'
      puts '1. Add Patient'
      puts '2. View Patients'
      puts '3. Add Doctor'
      puts '4. View Doctors'
      puts '5. Assign Doctor to Patient'
      puts '6. View Patients Doctor'
      puts '7. Add Appointment'
      puts '8. View Appointments'
      puts '9. Quit'
      puts '**********************************************'
      puts 'Enter your choice: '
      choice = gets.chomp.to_i

      case choice
      when 1
        add_patient
      when 2
        view_patient
      when 3
        add_doctor
      when 4
        view_doctor
      when 5
        assign_doctor
      when 6
        view_patient_doctor
      when 7
        add_appointment
      when 8
        view_appointment
      when 9
        puts 'Exiting...'
        break
      else
        puts 'Invalid choice! Please enter a number from 1 to 7.'
      end
    end
  end

  # Method to add patient to hospital
  # @return [string] Name of patient.
  # @return [integer] Age of patient
  # @return [string] Medical history of patient
  # @return [string] Sucessfully added message
  def add_patient
    puts 'Enter paient name: '
    name = gets.chomp
    if @patients.include?(name)
      puts 'Name already exist'
      return
    end
    while name.empty?
      puts 'Inavlid name'
      puts 'enter valid name: '
      name = gets.chomp
    end
    puts 'Enter age: '
    age = gets.chomp.to_i
    while age.to_i < 1 || age.to_i.negative?
      puts 'Invalid age'
      puts 'enter valid age: '
      age = gets.chomp
    end
    puts 'Enter Medical history: '
    history = gets.chomp
    while history.empty?
      puts 'Inavlid entry'
      puts 'enter patients medical history: '
      history = gets.chomp
    end
    patient = Patient.new(name, age, history)
    @patients << patient
    puts "Patient- #{patient.name} added sucessfully."
  end

  # Method to add Displays patients in hospital
  # @return [string] Details of patients
  def view_patient
    if @patients.empty?
      puts 'No patients Available'
      return
    end
    @patients.each_with_index do |patient, index|
      puts "#{index + 1}.Name: #{patient.name}, Age: #{patient.age}, Medical History: #{patient.history}"
    end
  end

  # Method to add doctor to hospital
  # @return [string] Name of doctor.
  # @return [string] speciality of doctor.
  # @return [integer] Experience of doctor.
  # @return [string] Sucessfully added message
  def add_doctor
    puts 'Enter doctor name: '
    name = gets.chomp
    while name.empty?
      puts 'name cannot be empty'
      puts 'enter Doctor name: '
      name = gets.chomp
    end
    puts 'Enter speciality: '
    speciality = gets.chomp
    while speciality.empty?
      puts 'Invalid Entry'
      puts 'enter Speciality: '
      speciality = gets.chomp
    end
    puts 'Enter years of experience: '
    experience = gets.chomp.to_i
    while experience.to_i < 1 || experience.to_i.negative?
      puts 'Invalid experience'
      puts 'enter valid experience: '
      experience = gets.chomp
    end
    doctor = Doctor.new(name, speciality, experience)
    @doctors << doctor
    puts "Doctor - #{doctor.name}  has been added."
  end

  # Method to add Displays doctors in hospital
  # @return [string] Details of doctor.
  def view_doctor
    if @doctors.empty?
      puts 'No doctors available.'
    else
      puts 'List of doctors:'
      @doctors.each_with_index do |doctor, index|
        puts "#{index + 1}. Name: #{doctor.name}, Speciality: #{doctor.speciality}, Experience: #{doctor.experience}"
      end
    end
  end

  # Method to assign doctor to patient
  # @return [string] to enter name of patient to assign
  # @return [string] doctor assigned message
  def assign_doctor
    if @patients.empty?
      puts 'No patients available.'
      return
    end
    if @doctors.empty?
      puts 'No Doctor available.'
      return
    end

    puts 'Select a patient to apply:'
    @patients.each_with_index do |patient, index|
      puts "#{index + 1}. #{patient.name}"
    end
    print "Enter patient's number: "
    patient_index = gets.chomp.to_i - 1
    while patient_index < 0 || patient_index.nil?
      puts 'enter valid number for patient'
      @patients.each_with_index do |patient, index|
        puts "#{index + 1}. #{patient.name}"
      end
      puts 'Re-enter patient number: '
      patient_index = gets.chomp.to_i - 1
    end
    selected_patient = @patients[patient_index]

    puts 'Select a Doctor:'
    @doctors.each_with_index do |doctor, index|
      puts "#{index + 1}. #{doctor.name}"
    end
    puts 'Enter Doctor number: '
    doctor_index = gets.chomp.to_i - 1
    while doctor_index < 0 || doctor_index.nil?
      puts 'enter valid number for doctor'
      @doctors.each_with_index do |doctor, index|
        puts "#{index + 1}. #{doctor.name}"
      end
      puts 'Re-enter doctor number: '
      doctor_index = gets.chomp.to_i - 1
    end
    selected_doctor = @doctors[doctor_index]

    assign = Assigned.new(selected_patient, selected_doctor)
    @assigned << assign
    puts 'Doctor assigned to patient Sucessfully:'
  end

  # Method to view patient assigned to the doctor
  # @return [string] to enter name of patient to check
  # @return [string] to details of doctor assigned to patient
  def view_patient_doctor
    if @assigned.empty?
      puts 'No doctors assigned yet.'
    else
      puts 'Enter Patient name: '
      name = gets.chomp
      while name.empty?
        puts 'Enter valid name:'
        puts 'Re-enter patient name: '
        name = gets.chomp
      end
      puts 'Assigned Doctor:'
      @assigned.each_with_index do |assign, index|
        puts "#{index + 1}. #{assign}"
      end
    end
  end

  # $appointments = {}
  def add_appointment
    if @patients.empty?
      puts 'Add doctor or patient to schedule appointments'
      return
    end
    if @doctors.empty?
      puts 'Add doctor or patient to schedule appointments'
      return
    end
    puts 'Select Patient'
    @patients.each_with_index do |patient, index|
      puts "#{index + 1}. #{patient.name}"
    end
    print "Enter patient's number: "
    patient_index = gets.chomp.to_i - 1
    while patient_index < 0 || patient_index.nil?
      puts 'enter valid number'
      @patients.each_with_index do |patient, index|
        puts "#{index + 1}. #{patient.name}"
      end
      puts 'enter patient number: '
      patient_index = gets.chomp.to_i - 1
    end
    selected_patient = @patients[patient_index]
    puts 'Select Doctors: '
    @doctors.each_with_index do |doctor, index|
      puts "#{index + 1}. #{doctor.name}"
    end
    puts 'Enter Doctor number: '
    doctor_index = gets.chomp.to_i - 1
    while doctor_index < 0 || doctor_index.nil?
      puts 'enter valid number'
      @doctors.each_with_index do |doctor, index|
        puts "#{index + 1}. #{doctor.name}"
      end
      puts 'enter patient number: '
      doctor_index = gets.chomp.to_i - 1
    end
    selected_doctor = @doctors[doctor_index]
    puts 'Enter Appointment date: (DD/MM/YYYY)'
    date = gets.chomp
    loop do
      if date.match(%r{^(0[1-9]|[1,2][0-9]|3[0,1])/(0[1-9]|1[0-2])/([1-5]\d{3})$})
        puts 'Date is valid'
        break
      else
        puts 'invalid date'
        puts 'enter valid date: '
        date = gets.chomp
      end
    end
    puts 'Enter Appointemnt Time:(enter time in 12 hrs format (hh:mmam/pm)'
    time = gets.chomp
    loop do
      if time.match(/^(0[1-9]|1[0-2])+:(0[1-9]|[1,2,3,4,5,6][0-9])+[a m]|[p m]$/)
        puts 'valid time'
        break
      else
        puts 'invalid time'
        puts 'enter valid time: (enter time in 12 hrs format {hh:mm(am/pm)})'
        time = gets.chomp
      end
    end
    appoint = Appointment.new(selected_patient, selected_doctor, date, time)
    @appointments << appoint
    puts 'Appointement added Sucessfully'
  end

  def view_appointment
    if @appointments.empty?
      puts 'No appointments available.'
    else
      puts 'Appointments:'
      @appointments.each_with_index do |appoint, index|
        puts "#{index + 1}. #{appoint}"
      end
    end
  end
end

# object of main class
system = HospitalManagement.new
system.display_menu
