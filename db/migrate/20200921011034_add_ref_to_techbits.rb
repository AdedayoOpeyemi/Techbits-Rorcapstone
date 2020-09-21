class AddRefToTechbits < ActiveRecord::Migration[6.0]
  def change
    add_reference :techbits, :author, references: :users, index: true

    # Just like the belongs_to contained class_name: :User, the foreign key
    # also needs a specific custom column name as :creator_id
    add_foreign_key :techbits, :users, column: :author_id
  end
end
