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

ActiveRecord::Schema[7.1].define(version: 20_240_515_084_233) do
  create_table 'logs', force: :cascade do |t|
    t.integer 'session', default: 0
    t.integer 'value', default: 0
    t.text 'remark'
    t.integer 'tag', default: 0
    t.integer 'result', default: 0
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_logs_on_user_id'
  end

  create_table 'sessions', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'user_agent'
    t.string 'ip_address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_sessions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'name'
    t.date 'dob'
    t.integer 'category', default: 0
    t.integer 'gender', default: 0
    t.string 'ulid'
    t.boolean 'verified', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['ulid'], name: 'index_users_on_ulid'
  end

  add_foreign_key 'sessions', 'users'
end
