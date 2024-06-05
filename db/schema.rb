# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_529_120_908) do
  create_table 'doses', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'morning', default: 0
    t.integer 'afternoon', default: 0
    t.integer 'evening', default: 0
    t.integer 'night', default: 0
    t.integer 'late_night', default: 0
    t.string 'medicine'
    t.string 'remarks'
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_doses_on_user_id'
  end

  create_table 'logs', force: :cascade do |t|
    t.integer 'session', default: 0
    t.integer 'value', default: 0
    t.text 'remark'
    t.integer 'tag', default: 0
    t.integer 'result', default: 0
    t.integer 'dose_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['dose_id'], name: 'index_logs_on_dose_id'
    t.index ['user_id'], name: 'index_logs_on_user_id'
  end

  create_table 'user_active_session_keys', primary_key: %w[user_id session_id], force: :cascade do |t|
    t.integer 'user_id'
    t.string 'session_id'
    t.datetime 'created_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
    t.datetime 'last_use', default: -> { 'CURRENT_TIMESTAMP' }, null: false
    t.index ['user_id'], name: 'index_user_active_session_keys_on_user_id'
  end

  create_table 'user_email_auth_keys', force: :cascade do |t|
    t.string 'key', null: false
    t.datetime 'deadline', null: false
    t.datetime 'email_last_sent', default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end

  create_table 'user_login_change_keys', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'login', null: false
    t.datetime 'deadline', null: false
  end

  create_table 'user_password_reset_keys', force: :cascade do |t|
    t.string 'key', null: false
    t.datetime 'deadline', null: false
    t.datetime 'email_last_sent', default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end

  create_table 'user_verification_keys', force: :cascade do |t|
    t.string 'key', null: false
    t.datetime 'requested_at', default: -> { 'CURRENT_TIMESTAMP' }, null: false
    t.datetime 'email_last_sent', default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.integer 'status', default: 1, null: false
    t.string 'email', null: false
    t.string 'password_hash'
    t.string 'name'
    t.date 'dob'
    t.integer 'category', default: 0
    t.integer 'gender', default: 0
    t.string 'ulid'
    t.index ['email'], name: 'index_users_on_email', unique: true, where: 'status IN (1, 2)'
    t.index ['ulid'], name: 'index_users_on_ulid'
  end

  add_foreign_key 'user_active_session_keys', 'users'
  add_foreign_key 'user_email_auth_keys', 'users', column: 'id'
  add_foreign_key 'user_login_change_keys', 'users', column: 'id'
  add_foreign_key 'user_password_reset_keys', 'users', column: 'id'
  add_foreign_key 'user_verification_keys', 'users', column: 'id'
end
