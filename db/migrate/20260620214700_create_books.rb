class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :text
      t.string :cover
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
