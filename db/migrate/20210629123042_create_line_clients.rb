class CreateLineClients < ActiveRecord::Migration[6.0]
  def change
    create_table :line_clients do |t|

      t.timestamps
    end
  end
end
