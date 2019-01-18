#Models Used
class Client < ActiveRecord::Base
  has_one :address
  has_one :mailing_address
  has_many :orders
  has_and_belongs_to_many :roles
end

class Address < ActiveRecord::Base
  belongs_to :client
end


class MailingAddress < Address
end

class Order < ActiveRecord::Base
  belongs_to :client, :counter_cache => true
end

class Role < ActiveRecord::Base
  has_and_belongs_to_many :clients
end

#Retrieving 1 object

#Model.find(pk)
client = Client.find(id) #raise exception RecordnotFound if not found
#first(options) return the first record matched
client = Client.first  #return nil
#last 
client = Client.last 
#Multiple objects send an aray of pk ids
client = Client.find(1, 10)
clients = Client.all

#Batch retrieving
#instead of User.all..each the below code is better
User.find_each(:batch_size => 500, :start => 200 ) do |user|
	Newsletter.weekly_deliver(user)
end

#Conditionals are used to represent WHERE part of SQL
Client.first(:conditionals => "orders_count = '2'")
#instead of hardcoding 2 we can use variable
Client.first(:conditionals => ["orders_count = ?", params[:orders]] )
#if two conditions then
Client.first(:conditionals => ["orders_count = ? AND locked = ? ",params[:orders],false])

Client.all(:conditionals => ["created_at IN (?)", (params[:start_date].to_date)..(params[:end_date].to_date)])
#the above code checks each second

#So use > <
Client.all(:conditionals => ["created_at > ? AND created_at < ?", params[:start_date], params[:end_date]])

#options other than :conditionals are also provided
#Model.find(:first, :last, id or array of ids)

Client.all(:order => "created_at") #ascending
Client.all(:order => "created_at DESC")
#multiple columns to order on 
Client.all(:order => "orders_count ASC, created_at DESC")

#selecting fields

Client.all(:select => "viewable_by, locked") #but all objects are readonl

Client.all(:select => "DISTINCT(name)")

#SQL limit 
Client.all(:limit => 5, :offset => 5)

Order.all(:group => "date(created_at)", :order => "created_at")
Order.all(:group => "date(created_at)", :having => ["created_at > ?", 1.month.ago])

#by setting  :readonly => true  disallow modificaion/destroyal

#Avoid race conditions by locking optimistic/pessimistic
#optimistic Allows multiple users to access same record
#table needs lock_version column (defualt to 0)
c1 = Client.find(1)
c2 = Client.find(1)

c1.name = "Michael"
c1.save

c2.name = "should fail"
c2.save # Raises a ActiveRecord::StaleObjectError

#we can change lock_version using set_locking_column
#pessimistic uses locking provided by underlying database
pass :lock => true to Model.find()

#
#Joining tables: 3 ways
#1st way - raw sql
Client.all(:joins => 'LEFT OUTER JOIN addresses ON adresses.client_id = clients.id')

#2nd way - only INNER JOIN

Category.all :joins => :posts
Posts.all :joins => [:category, :comments]
Posts.all :joins => [:comments => :guest] #joining nested associations

#own SQL 
Client.find_by_sql("SQL statement") #retrieves instantiated objects

Client.connection.select_all("SQL statement") #will not instantiate objects
#returns array of hashes
#check existance  of objects
Client.exists?(1,2,3) #true if any of these exists
#or obj.exists?([1,2,3])
Client.exists?(:first_name => 'Ryan') #similar to conditionals
Client.exists? #w/o parameter checks if table empty or not

#Calculations
count, average, minimum, maximum, sum
