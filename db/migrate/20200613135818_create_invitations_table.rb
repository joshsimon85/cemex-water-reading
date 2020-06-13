class CreateInvitationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.belongs_to :user, null: false
      t.string :token, null: false
      t.timestamps
    end
  end
end
