class CreateRecordRevisionData < ActiveRecord::Migration
  def change
    create_table :record_revision_data do |t|
      t.references :parent, index: true, :polymorphic => true
      t.string :operation
      t.text :data
      t.references :author, index: true, :polymorphic => true
      t.timestamps
    end
  end
end
