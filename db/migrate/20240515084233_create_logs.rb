# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.integer :session, default: 0
      t.integer :value, default: 0
      t.text :remark
      t.integer :tag, default: 0
      t.integer :result, default: 0

      t.belongs_to :user
      t.timestamps
    end
  end
end
