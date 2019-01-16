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
# methods to work with errors
#errors.add_to_base objects state not attrib

class Person < ActiveRecord::Base
	def a_method_for_validation
		errors.add_to_base("Message")
	end
end
#errors.add manually add error related to attrib

class Person < ActiveRecord::Base
	def a_validation_method
		errors.add(:name, "Message")
	end
end

#errors.on to get error message on a pariculat attrib
#errors.clear just clears the errors map

person = Person.new #doesnt call validations
person.valid? #calls validations
person.errors.on(:name)
person.errors.clear #empties the errors
 
person.save #save returns false even when the errors is empty as the validations are run 

person.errors.size # return the no of errors currents for a object

#Displaying errors in view

class Person < ActiveRecord::Base
	validates_presence_of :value, :description
	validates_numericality_of :value, :allow_nil => true
end

<% form_for(@products) do |f| %>
	<%= f.error_essages %>
	<p>
		<%= f.label :description %>
		<%= f.text_field :description %>
	</p>
	<p>
		<%= f.label :value %>
		<%= f.text_field :value %>
	</p>
	<p>
		<%= f.submit ""%>
	</p>
<% end %>