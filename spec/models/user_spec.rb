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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
