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
require 'test_helper'

class LogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
