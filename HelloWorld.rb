#!/usr/local/bin/ruby -w

#puts "Hello World!"
def hW()
	puts "Hello World"
end

def hi(name = "World")
	puts "Hello #{name}"
end
hW()
hi()
hi("User")

class Greeter
	def initialize(name = "World")
		@name = name
	end

	def hi
		puts "Hello #{@name}"
	end

	def bye
		puts "bye #{@name}"
	end
end

greeter = Greeter.new("User1")
greeter.hi
greeter.bye

#Greeter.instance_methods is used to get all instance methods
#puts Greeter.instance_methods(false) is used to get only user defined methods

puts "respond_to? value for name: #{greeter.respond_to?("name")}"
puts "respond_to? value for hi: #{greeter.respond_to?("hi")}"
puts "respond_to? value for bye: #{greeter.respond_to?("bye")}"

# In Ruby we can open up the class even after class definition
class Greeter
	attr_accessor :name
end
puts "respond_to? value for name: #{greeter.respond_to?("name")}"
greeter.name = "User2"
puts "greeter name: #{greeter.name}"

# A complete example

class MassGreeter
	attr_accessor :names
	def initialize(names = "World")
		@names = names
	end

	def say_hi
		if @names.nil?
			puts "..."
		elsif @names.respond_to?("each")
			@names.each do |name|
				puts "Hello #{name}"
			end
		else
			puts "Hello #{names}"
		end
	end
	def say_bye
		if @names.nil?
			puts "..."
		elsif @names.respond_to("join")
			puts "Bye #{@names.join(",")}"
		else
			puts "Bye #{@names}"
		end
	end

end
mGreeter = MassGreeter.new("User1")
mGreeter.say_hi
mGreeter = MassGreeter.new
mGreeter.names = ["User1", "User2"]
mGreeter.say_hi
