class Student
	attr_accessor :first, :last, :phono

	def introduction(target)
		puts "Hello #{target} i am #{first}"
	end

	def favorite_number
    7
  end

end

s = Student.new
s.first  = "Rahul"
s.introduction("User")
puts "#{s.favorite_number}"

menu = {:m1 => 2, :m2 => 3, :m3 => 4}
menu.each do |key, value|
	puts "key is #{key}, value is #{value}"
end

def add(numbers)
	sum = 0
	numbers.each do |i|
		sum += i
	end
	return sum
end

numbers = []

# fills numbers array with multiples of the value y less than max
def multiples(y, numbers, max)
	x = 0
	loop do
		x = x.to_i() + y.to_i()
		break if(x >= max)
		numbers.push(x)
	end
end
multiples(3, numbers,1000)
multiples(5, numbers, 1000)
puts add(numbers)

fruits = {"apple"=> 3, "banana" => 4}
p fruits
colors = Hash["red" => 2, "yellow"=> 4]
p colors