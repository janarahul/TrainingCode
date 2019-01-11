class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :null => false
      t.text :description
      #t.column :name, :string, :null => false :string, :integer, :float, :text, :primary_key, :boolean, :timestamp

      t.timestamps
    end

    change_table :products do |t|
      t.remove :description, :name
      t.string :part_number
      t.index :part_number
      t.rename :upccode, :upc_code
    end
    ''' #same as
    remove_column :products, :description
    remove-column :products, :name
    add_column :products, :part_number, :string
    add_index :products, :part_number
    rename_column :products, :upccode, :upc_code
    '''

    create_table :products do |t|
      t.references :category
      t.references :attachment, :polymorphic => {:default => 'Image' }
    end

  end

  def self.down
    drop_table :products
  end
end
