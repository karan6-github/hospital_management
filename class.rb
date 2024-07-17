# class which initializes patient details
class Patient
  attr_accessor :name, :age, :history

  def initialize(name, age, history)
    @name = name
    @age = age
    @history = history
  end

  def to_s
    "#{@name}: age - #{@age}, history - #{@history}"
  end
end

# class which initializes Doctor details
class Doctor
  attr_accessor :name, :speciality, :experience

  def initialize(name, speciality, experience)
    @name = name
    @speciality = speciality
    @experience = experience
  end

  def to_s
    "#{@name}: Speciality - #{@speciality}, Experience - #{@experience}"
  end
end

# class which initializes details to assign doctor to patient
class Assigned
  attr_accessor :patient, :doctor

  def initialize(patient, doctor)
    @patient = patient
    @doctor = doctor
  end

  def to_s
    "Name: #{@doctor} "
  end
end

class Appointment
  attr_accessor :patient, :doctor, :date, :time

  def initialize(patient, doctor, date, time)
    @patient = patient
    @doctor = doctor
    @date = date
    @time = time
  end

  def to_s
    " Patient:#{@patient}, Doctor:#{@doctor}, Date:#{date}, time:#{time} "
  end
end