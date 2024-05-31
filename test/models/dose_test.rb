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
require 'test_helper'

class DoseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
