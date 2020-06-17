class CreateTableAudits < ActiveRecord::Migration[6.0]
  def change
    create_table :audits do |t|
      t.string :created_by, null: false
      t.string :action_type, null: false
      t.text :record_type, null: false
      t.timestamps
    end
  end
end
