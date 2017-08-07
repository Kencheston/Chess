class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @boss = boss
    @name = name
    @title = title
    @salary = salary
    add_boss unless boss.nil?
  end

  def bonus(multiplier)
    bonus = (@salary) * multiplier
  end

  def add_boss
    @boss.add_employee(self)
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss, employees=[])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    combined_sal = @employees.reduce { |e1, e2| e1.salary + e2.salary }
    bonus = combined_sal * multiplier
  end

  def add_employee(employee)
    @employees << employee
  end

  protected
  def total_salary
    total = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total += employee.salary + employee.total_salary
      else
        total += employee.salary
      end
    end
    total
  end
end


bob = Manager.new("bob", "boss", "1000000000", nil)

steve = Employee.new("steve", "underling", 100000, bob)
rob = Employee.new("rob", "underling", 100000, bob)

ken = Employee.new("ken", "peon", 200000, steve)

bob.bonus(1.1)
