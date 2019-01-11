class Person 
	def initialize(name)
		@name  = name
	end
end

p = Person.new(:name => "John Doe")

p.new_record?
p.save
p.new_record?

class Person 
	validates_presence_of :name
end

Person.create(:name => "Rahul").valid? #true
Person.create(:name => nil).valid? #false


p = Person.new
p.errors #errors is nil even though :name not there as validations not tested

p.valid? #tests validations and returns
p.errors # shows errors

p.save
p.save! # ! raises exception
 
Person.create!

Person.new.errors.invalid?(:name) # => false as validations are not run
Person.create.errors.invalid?(:name) # => true


#validation helpers

validates_presence_of
validates_associated
validates_acceptance_of

validates_confirmation_of

class Person < ActiveRecord::Base
	validates_confirmation_of :email
end

#In view

<%= text_field :person, :email %>
<%= text_field :person, :email_confirmation %> #only if confirmation attribute is not nil, so check presence of that attrib

#common validation options
:allow_nil
:allow_blank
:message 
:on

