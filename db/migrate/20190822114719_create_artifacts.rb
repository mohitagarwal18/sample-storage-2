class CreateArtifacts < ActiveRecord::Migration[5.2]
  def change
    create_table :artifacts do |t|
      t.string :file_location
      t.string :file_name
      t.integer :file_size
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :artifacts, [:user_id, :created_at , :file_name ]
    
  end
end
