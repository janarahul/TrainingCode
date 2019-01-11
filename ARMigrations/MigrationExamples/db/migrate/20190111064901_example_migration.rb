class ExampleMigration < ActiveRecord::Migration
  def self.up
  	create_table :products do |t|
  		t.references :category
  	end

  	
  	execute <<-SQL
  		ALTER TABLE products 
  			ADD CONSTRAINT fk_product_categorties
  			FOREIGN KEY category_id
  			REFERENCES categories(id)
  	SQL
  	add_column :products, :home_page_url, :string
  	rename_column :products, :email_address, :email
  end

  def self.down
  	rename_column :products, :email, :email_address
  	remove_column :products, :home_page_url
  	execute <<-SQL 
  		ALTER TABLE products DROP FOREIGN KEY fk_product_categorties
  	SQL
  	drop_table :products
  end
end
