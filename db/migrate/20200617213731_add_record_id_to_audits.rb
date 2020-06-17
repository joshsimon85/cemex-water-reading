class AddRecordIdToAudits < ActiveRecord::Migration[6.0]
  def change
    add_column :audits, :record_id, :string, null: false
  end
end
