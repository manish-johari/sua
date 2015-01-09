class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :name
      t.string :status
      t.date :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
