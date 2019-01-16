class Customer < ActiveRecord::Base
	has_many :order, :dependent => :destroy
end

class Order < ActiveRecord::Base
	belongs_to :customer
end

'''
    belongs_to
    has_one
    has_many
    has_many :through
    has_one :through
    has_and_belongs_to_many

'''

class Supplier < ActiveRecord::Base
	has_one :account 
end

class Customer < Aciverecord::Base
	has_many :orders #model name pluralized
end

#has_many :trough --- a many-many relation by going through a third model

class Pysician < ActiveRecord::Base
	has_many :appointments
	has_many :patiens, :through => :appointments
end
class Appointment < ActiveRecord::Base
	belongs_to :pysician
	belongs_to :patient
end

class Patient < ActiveRecord::Base
	has_many :appointments
	has_many :pysicians, :through => :appointments
end

#similarly has_one :through

class Supplier < Aciverecord::Base
	has_one :Account 
	has_one :AccountHistory, :through => :account

end

class Account < Aciverecord::Base
	belongs_to :supplier
	has_one :account_history
end

class Accounthistory < ActiveRecord::Base
	belongs_to :account

end

#has_and_belongs_to_many used to directly create many-to-many model

class Part < ActiveRecord::Base
	has_and_belongs_to_many :assemblies
end

class Assembly < ActiveRecord::Base
	has_and_belongs_to_many :parts
end

#polymorphic association
class Picture < ActiveRecord::Base
	belongs_to :imageable, :polymorphic => true
end

class Customer < ActiveRecord::Base
	has_many :pictures, :as => :imageable
end

class Product < ActiveRecord::Base
	has_many :pictures, :as =>imageable
end

#Self join

class Employee < ActiveRecord::Base
	has_many :subordinates, :class_name => "Employee", :foreign_key => "manager_id"
	belongs_to :manager, :class_name => "Employee"	

end

#caching
'''

customer.orders(true).size #cached copy is not used
'''

class Order < ActiveRecord::Base
	belongs_to :customer
end

class CreateOrder < ActiveRecord::Migrations
	def self.up
		create_table :orders do |t|
			t.integer :cusomer_id
		end
end

class Assembly < ActiveRecord::Base
	has_and_belongs_to_many :parts
end

class Part < ActiveRecord::Base
	has_and_belongs_to_many :assemblies
end

class CreateAssemblyPartJoinTable < ActiveRecord::Migrations
	def self.up
		create_table :assemblies_parts, :id => false do |t|
			t.integer :assembly_id
			t.integer :part_id
		end
	end
end




