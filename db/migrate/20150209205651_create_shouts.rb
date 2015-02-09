class CreateShouts < ActiveRecord::Migration
  def change
    create_table :shouts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.datetime :created_at, null:false
      t.datetime :updated_at, null:false
    end
  end
end
