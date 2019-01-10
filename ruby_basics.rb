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

'''Regular Expressions
/Perl|Python/
/P(erl|ython)/
=~ is the match operator return starting position

'''
line = "Is Python a scripting language"
puts line =~ /Perl|Python/

#blocks between braces or do .. end

def call_back
	yield
	yield
end
call_back { puts "This is in a block"}

a = %w(ant bee fly)
a.each do |insect|
	puts insect
end
'''
#reading input

line = gets
puts line
'''
#gets also stores value in $_ which is the default value
'''
while gets
	if /Ruby/
		puts "Ruby entered"
	end
end
'''
#ARGF.each {|line| puts line if line =~ /Ruby/ }

class Song
	def initialize(name, artist, year)
		@name = name
		@artist = artist
		@year = year
	end
end

a_song = Song.new("Call it what you want", "TS", 2018)
p a_song

#classes are never closed
class Song
	def to_s
		"#{@name}--#{@artist}--#{@year}"
	end
end
puts a_song

class KaroakeSong < Song
	def initialize(name, artist, year, lyrics)
		super(name, artist, year)
		@lyrics = lyrics
	end

	'''def to_s
    "KS: #{@name}--#{@artist} (#{@year}) [#{@lyrics}]" #Not a good practice
  	end'''
  	def to_s
		super + " lyrics: #{@lyrics}"
	end
end


k_song = KaroakeSong.new("Call it what you want", "TS", 2018, "kajsgfkjas")
puts k_song

'''
class Song
  def name
    @name
  end
  def artist
    @artist
  end
  def duration
    @duration
  end
end
'''
#a better way

class Song 
	attr_reader :name, :artist, :duration
end 



#aSong.artist = "TS" #error s no artist= method
#p aSong.artist  

class Song
	def artist=(artist)
		@artist = artist
	end
end


class Song
	def durationInMin
		#virtual attribute
		@duration/60.0
	end

	def durationInMin=(value)
		@duration = (value * 60).to_i
	end

end
aSong = Song.new("Bicylops", "Fleck", 260)
p aSong.artist
aSong.artist = "TS"
p aSong.artist

aSong.durationInMin = 4.2
p aSong.duration

#class variable defineed using @@

class Song
	@@plays = 0
	def initialize(name, artist, dur)
		@name = name
		@artist = artist
		@duration = dur
		@plays =0
	end
	def plays
		@plays += 1
		@@plays += 1
		return self
	end
	def to_s
		puts "#{@plays}"
	end

end
aSong = Song.new("call","TS",200)
aSong.plays
aSong.plays
bSong = Song.new("it","TS",700)
bSong.plays
bSong.plays
#puts "#{aSong.plays} #{bSong.plays}"

class Song 
	MAXTIME = 5*60
	def Song.is_too_long?(aSong)
		return (aSong.duration > MAXTIME)
	end
end
puts Song.is_too_long?(aSong)
puts Song.is_too_long?(bSong)

#singleton
class Logger
	private_class_method :new
	def Logger.create
		@@logger = new unless @@logger
		return @@logger
	end
end

#puts Logger.create.id
#puts Logger.create.id


class SongList
	def initialize
		@songs = Array.new
	end
	def append(aSong)
		@songs.push(aSong)
	end
	def deleteFirst
		@songs.shift
	end
	def deleteLast
		@songs.pop
	end
end

list = SongList.new
#list.append(Song.new("what","TS",1).plays).append(Song.new("you","TS",2).plays.plays)

class SongList
	def [](key)
		if key.kind_of?(Integer)
			@songs[key]
		else
			'''for i in 0...@songs.length
				return @songs[i] if key == @songs[i].name
			end'''
			result = @songs.find { |song| key == song.name}

		end
		return result
	end
end

class SongList
  	def [](key)
    	return @songs[key] if key.kind_of?(Integer)
    	return @songs.find { |aSong| aSong.name == key }
 	end
end
puts list["what"]

#iterations in ruby

def iterations
	yield
	yield
end
iterations {puts "Thsi is printed twice"}

def fib(max)
	x, y  = 1, 1
	while(x <= max)
		yield x
		x, y = y, x+y
	end
end
fib(100) { |f| printf "#{f} "}




class Array
  def find
    for i in 0...size
      value = self[i]
      #puts size
      return value if yield(value)
    end
    return nil
  end
end
p [1, 3, 5, 7, 9].find {|v| v*v > 30 }

[1, 2, 3, 4].each {|p| print p}
#.collect results retureed are used to make a new array
p [1 ,2, 3, 4 ].collect {|p| p+1}

f = File.open("textfile.txt")
f.each do |line|
	puts line
end
f.close

module Inject
	def inject(n)
		self.each {|value| n = yield(n, value)}
		n
	end
	def sum
		inject(0) {|n, value| n+value}
	end
end
class Array
	include Inject
end

p [1, 2, 3, 4].sum

class File
	def File.openAndProcess(*args)
		f = File.open(*args)
		yield f
		f.close
	end
end
File.openAndProcess("textfile.txt", "r") {|f| f.gets}

class File
	def File.myOpen(*args)
		f = File.open(*args)
		if block_given?
			yield f
			f.close()
			f = nil
		else 
			return f
		end
	end
end

file = File.myOpen("textfile.txt", "r")
puts file.gets

3.times {|i| puts i}
3.upto(7) {|i| puts i}
3.downto(1) {|i| puts i}
3.step(8,2) {|i| puts i}


#settings delimiter for strings 
# done using %q %Q 
#here document
document = <<HERE
This is a here document
Example!
HERE
puts document
greeting = <<HERE + <<THERE + "World"
Hello
HERE
There
THERE
puts greeting

p %{a word}  # => "a word"
p %Q{a word} # => "a word"
p %q{a word} 

songFile = File.open("textfile.txt", "r")

songs = SongList.new
songFile.each do |line|
  file, length, name, title = line.chomp.split(/\s*\|\s*/)
  name.squeeze!(" ")
  mins, secs = length.scan(/\d+/)
  songs.append Song.new(title, name, mins.to_i*60+secs.to_i)
end
p songs[1]

def showRE(string, pattern)
	if string =~ pattern
		puts "#{$`}<<#{$&}>>#{$'}"
	else
		puts "no match"
	end
end
showRE("interesting",/t/)

#RE all character match itself expect ., |, (, ), [, {, +, \, ^, $, *, and ? 

#RE anchor ^ $ \A \z
showRE('Mississippi', /(\w+)\1/)
showRE('He said "Helllo"', /(\w)\1/)

str = 'a\b\c'
p str.gsub(/\\/, '\\\\')

#Ranges 
for i in 0..5
	puts i
end
for i in 0...5
	puts i
end

class VU
  include Comparable
 
  attr :volume
  def initialize(volume)  # 0..9
    @volume = volume
  end
  def inspect
    '#' * @volume
  end
  # Support for ranges
  def <=>(other)
    self.volume <=> other.volume
  end


  def succ
    raise(IndexError, "Volume too big") if @volume >= 9
    VU.new(@volume.succ)
  end
end
medium = VU.new(4)..VU.new(7)
p medium.to_a 	
p medium.include?(VU.new(3))

#More on Methods 
def varArgs(arg1, *rest )
	puts "#{arg1} #{rest.join(", ")}"
end

varArgs("one")
varArgs("one", "two")

#Example on block passed as proc object
class TaxCalculator
	def initialize(name, &procblock)
		@name = name
		@procblock = procblock
	end
	def getTax(value)
		"#@name is = #{ @procblock.call(value) }"
	end
end


tc = TaxCalculator.new("Sales tax") { |amt| amt * 0.075 }
p tc.getTax(100)

def fiveArgs(a, b, c, d, e)
	puts "#{a} #{b} #{c} #{d} #{e}"
end
fiveArgs(*(0...5))

#Dynamic blocks

times = 't'
if times =~ /^t/
	calc = proc { |n| n*n}
else
	calc = proc {|n| n+n }
end

p (0..5).collect(&calc)

#Expresions

puts [ 3, 1, 7, 0 ].sort.reverse
a = b = c =10
puts (a.*(b)).+(c)

#commands expression
puts %x{echo "Hello there"}
#print `data`

'''
When an assignment has more than one lvalue,
the assignment expression returns an array of
the rvalues. If an assignment contains more lvalues than rvalues,
the excess lvalues are set to nil. If a multiple assignment contains
more rvalues than lvalues, the extra rvalues are ignored.
As of Ruby 1.6.2, if an assignment has one lvalue and multiple rvalues,
the rvalues are converted to an array and assigned to the lvalue. 
'''
#case statement

year =2019

kind = case year
         when 1850..1889 then "Blues"
         when 1890..1909 then "Ragtime"
         when 1910..1929 then "New Orleans Jazz"
         when 1930..1939 then "Swing"
         when 1940..1950 then "Bebop"
         else                 "Jazz"
       end
print kind


def doUntil(cond)
  yield
  retry unless cond
end


i = 0
doUntil(i > 3) {
  print i, " "
  i += 1
}

#Exceptions

'''opFile = File.open("textfile.txt", "w")
begin 

	while data = socket.read(512)
    	opFile.write(data)
  	end

rescue NameError
	$stderr.print "IO fialed "+ $!
	opFile.close
	#File.delete("textfile.txt")
	#raise	
end
'''
#MIXIN

module Debug
  def whoAmI?
    "#{self.type.name} (\##{self.id}): #{self.to_s}"
  end
end
class Phonograph
  include Debug
  # ...
  def initialize(name)
  	@name = name
  end
  def to_s
  	"#{@name}"
  end

end
class EightTrack
  include Debug
  def initialize(name)
  	@name = name
  end
  def to_s
  	"#{@name}"
  end
  # ...
end
ph = Phonograph.new("West End Blues")
et = EightTrack.new("Surrealistic Pillow")

puts ph.whoAmI?
puts et.whoAmI?

class Song
  include Comparable
  def <=>(other)
    self.duration <=> other.duration
  end
end

song1 = Song.new("xyz", "abc", 250)
song2 = Song.new("pqr", "rsst", 270)
song3 = Song.new("pqrs", "st", 270)

puts song2 == song3
puts song1 == song3

class Array
  include Inject
end

puts [1, 2, 3, 4].sum

module Notes
	attr :concertA
	def tuning(amt)
		@concertA = 440.0 + amt
	end
end

class Trumpet
	include Notes
	def initialize(tune)
		tuning(tune)
		puts "#{concertA}"
		puts "#{@concertA}"
	end
end
Trumpet.new(-5.3)

module A
  HELLO = "hi"
  def sayhi
    puts HELLO
  end
end

module B
  HELLO = "bye"
  def sayhi
    puts HELLO
  end
end

class C
  include B
  include A
end

c = C.new
c.sayhi

def foo(bar) bar = 'reference' end; baz = 'value'; foo(baz); puts "Ruby is pass-by-#{baz}"

def change_string(str)
  str << " This "
  str << " is "
  str << " displayed "
  str << " right?"
  str = "What? I didn't say anything." # I'm so sneaky
end

be_nice_to_me = "hello"
change_string(be_nice_to_me)
puts be_nice_to_me


h = Hash.new(0)  # New hash pairs will by default have 0 as values
h[1] += 1  #=> {1=>1}
h[2] += 2  #=> {2=>2}

p h

h = Hash.new{[]}  # Empty array as default value
h[1] <<= 1  #=> {1=>[1]}                  ← Ok
h[2] <<= 2  #=> {1=>[1,2], 2=>[1,2]}      ← Why did `1` change?
h[3] << 3   #=> {1=>[1,2,3], 2=>[1,2,3]}  ← Where is `3`?
p h

h = Hash.new([])
h[0] << 'a'  #=> ["a"]
h[1] << 'b'  #=> ["a", "b"]
h[1]         #=> ["a", "b"]

h[0].object_id == h[1].object_id  #=> true
p h  #=> {}