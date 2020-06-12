class AddSuspendedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :suspended, :boolean, null: false, default: false
  end
end
