class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :provider
      t.text :avatar_url
      t.string :token
      t.timestamps
    end
  end
end