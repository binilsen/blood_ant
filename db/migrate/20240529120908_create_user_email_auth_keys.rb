# frozen_string_literal: true

class CreateUserEmailAuthKeys < ActiveRecord::Migration[7.1]
  def change
    # Used by the email auth feature
    create_table :user_email_auth_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
      t.datetime :email_last_sent, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
