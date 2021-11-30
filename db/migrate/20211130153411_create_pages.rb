class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.string :slug

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
