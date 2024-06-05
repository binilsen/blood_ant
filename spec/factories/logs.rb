# frozen_string_literal: true

# == Schema Information
#
# Table name: logs
#
#  id         :integer          not null, primary key
#  remark     :text
#  result     :integer          default("normal")
#  session    :integer          default("immediate")
#  tag        :integer          default("default")
#  value      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dose_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_logs_on_dose_id  (dose_id)
#  index_logs_on_user_id  (user_id)
#
FactoryBot.define do
  factory :log do
    remark { Faker::Lorem.sentence }
    result { Log.results.keys.sample }
    session { Log.sessions.keys.sample }
    tag { Log.tags.keys.sample }
    created_at { Faker::Date.between(from: '2014-09-23', to: '2014-12-25') }
    value { Faker::Number.between(from: 90, to: 900) }
    dose
    user
  end
end
