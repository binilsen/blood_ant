# frozen_string_literal: true

class CreateDoses < ActiveRecord::Migration[7.1]
  def change
    create_table :doses do |t|
      t.belongs_to :user
      t.integer :morning, default: 0
      t.integer :afternoon, default: 0
      t.integer :evening, default: 0
      t.integer :night, default: 0
      t.integer :late_night, default: 0
      t.string :medicine, null: true
      t.string :remarks, null: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
