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
require 'rails_helper'

RSpec.describe Log, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
