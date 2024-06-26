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
class User < ApplicationRecord
  include Rodauth::Rails.model

  enum :status, unverified: 1, verified: 2, closed: 3
  enum category: { one: 0, two: 1 }
  enum gender: { male: 0, female: 1, other: 2 }

  has_many :logs, dependent: :destroy
  has_many :doses, dependent: :destroy

  validates :name, presence: true

  def active_dose
    doses.active.first
  end
end
