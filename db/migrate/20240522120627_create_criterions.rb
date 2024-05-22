# frozen_string_literal: true

class CreateCriterions < ActiveRecord::Migration[7.1]
  def change
    create_table :criterions do |t|
      t.float :weight

      t.timestamps
    end
  end
end
