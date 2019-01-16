#callbacks called at certain moments of object, to use them register< 
class User < ActiveRecord::Base
	validates_presence_of :login, :email
	before_validation :method_to_register

	protected #good to define as protected
	def method_to_register
		if login.nil?
			self.login = email unless email.blank?
		end
	end
end
#can take blocks
class User < ActiveRecord::Base
	validates_presence_of :login, :email
	before_create { |user| user.name  = user.login.capitalize if user.name.blank? }

end

#Callback classes
class PictureFileCallbacks
	def after_destroy(picture_file)
		File.delete(picture_file.filepath) if File.exists?(picture_file.filepath)
	end
end
#to use it
class PictureFile < AciveRecord::Base
	after_destroy PictureFileCallbacks.new

	end

end

#instead of instance method we can use class methods
class PictureFileCallbacks
	def self.after_destroy(picture_file)
		File.delete(picture_file.filepath) if File.exists?(picture_file.filepath)
	end
end

class PictureFile < ActiveRecord::Base
	after_destroy PictureFileCallbacks # no need to initialize
end

#observer

class User < ActiveRecord::Observer
	def after_create(model)

	end
end

