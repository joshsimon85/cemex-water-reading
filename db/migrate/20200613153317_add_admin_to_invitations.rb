class AddAdminToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :admin, :boolean, default: false
  end
end
