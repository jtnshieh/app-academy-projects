class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end


end

class Manager < Employee

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary_of_employees * multiplier
  end


  def total_salary_of_employees
    sub_salaries = []
    @employees.each do |employee|
      if employee.class == Manager
        sub_salaries << employee.salary 
        sub_salaries << employee.total_salary_of_employees
      else
        sub_salaries << employee.salary
      end
    end
    sub_salaries.reduce(:+)
  end
end

david = Employee.new("David","TA",10000,"darren")
shawna = Employee.new("Shawna","TA",12000,"darren")
darren = Manager.new("Darren","TA manager",78000,"Ned",[shawna, david])
ned = Manager.new("Ned","Founder",100000,nil,[darren])



p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
