class CreateProducts < ActiveRecord::Migration
	def self.up
		create_table :products do |t| #a primary key column id is also added
			t.text :descriptions
			t.string :name
			t.timestamps #created_at and updated_at are added
	end

	def self.down
		drop_table :products
	end
end


class AddReceiveNewsletterToUsers < ActiveRecord::Migration
	def self.up
	end
		changex`_table :user 
	def self.down
		remove_column :col1, :col2
	end
end
