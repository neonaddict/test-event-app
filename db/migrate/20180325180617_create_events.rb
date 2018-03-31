class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :region
      t.string :city
      t.string :address
      t.datetime :date
      t.belongs_to :organizer, index: true
      t.text :description
      t.string :link
      t.timestamps
    end
  end
end
