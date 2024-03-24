class CreateLogins < ActiveRecord::Migration[7.2]
  def change
    create_table :logins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :device_id
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
