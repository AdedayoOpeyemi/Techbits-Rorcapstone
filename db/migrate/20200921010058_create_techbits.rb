class CreateTechbits < ActiveRecord::Migration[6.0]
  def change
    create_table :techbits do |t|
      t.text :bit

      t.timestamps
    end
  end
end
