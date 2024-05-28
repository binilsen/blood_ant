# frozen_string_literal: true

class CreateRodauth < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :status, null: false, default: 1
      t.string :email, null: false
      t.index :email, unique: true, where: 'status IN (1, 2)'
      t.string :password_hash
      t.string :name
      t.date :dob
      t.integer :category, default: 0
      t.integer :gender, default: 0
      t.string :ulid, index: true
    end

    # Used by the password reset feature
    create_table :user_password_reset_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
      t.datetime :email_last_sent, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    # Used by the account verification feature
    create_table :user_verification_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :requested_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :email_last_sent, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    # Used by the verify login change feature
    create_table :user_login_change_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.string :login, null: false
      t.datetime :deadline, null: false
    end

    # Used by the active sessions feature
    create_table :user_active_session_keys, primary_key: %i[user_id session_id] do |t|
      t.references :user, foreign_key: true
      t.string :session_id
      t.datetime :created_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :last_use, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
