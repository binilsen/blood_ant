# frozen_string_literal: true

# == Schema Information
#
# Table name: doses
#
#  id         :integer          not null, primary key
#  afternoon  :integer          default(0)
#  evening    :integer          default(0)
#  medicine   :string
#  morning    :integer          default(0)
#  night      :integer          default(0)
#  remarks    :string
#  status     :integer          default("inactive")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_doses_on_user_id  (user_id)
#
FactoryBot.define do
  factory :dose do
    afternoon { Faker::Number.between(from: 4, to: 50) }
    evening  { Faker::Number.between(from: 4, to: 50) }
    medicine { Faker::Lorem.sentence }
    morning { Faker::Number.between(from: 4, to: 50) }
    night { Faker::Number.between(from: 4, to: 50) }
    remarks { Faker::Lorem.sentence }
    status { Dose.statuses.keys.sample }
    user
  end
end
