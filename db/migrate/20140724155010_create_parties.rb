class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|

      t.string      :name
      t.string      :hash_tag
      t.text        :queue, default: "[]"

      t.timestamps
    end
  end
end
