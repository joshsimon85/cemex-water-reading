class AddRoleToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :role, :string, null: false
  end
end
