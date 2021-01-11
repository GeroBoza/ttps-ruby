class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.belongs_to :user, null: false, foreign_key: {on_delete: :cascade}
      t.string :name, null: false

      t.timestamps
    end
    add_index :books, :name, unique: true
  end
end
