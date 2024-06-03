# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  category      :integer          default("one")
#  dob           :date
#  email         :string           not null
#  gender        :integer          default("male")
#  name          :string
#  password_hash :string
#  status        :integer          default("unverified"), not null
#  ulid          :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE WHERE status IN (1, 2)
#  index_users_on_ulid   (ulid)
#
FactoryBot.define do
  factory :user do
    category { User.categories.keys.sample }
    dob { Faker::Date.between(from: 20.years.ago, to: 15.years.ago) }
    email { Faker::Internet.email }
    gender { User.genders.keys.sample }
    name { Faker::Name.name }
    password { 'test1234' }
    status { 'verified' }
  end
end
