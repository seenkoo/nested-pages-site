class AddFormattedBodyToPages < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :formatted_body, :text
  end
end
