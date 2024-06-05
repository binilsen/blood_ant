# frozen_string_literal: true

# == Schema Information
#
# Table name: doses
#
#  id         :integer          not null, primary key
#  afternoon  :integer          default(0)
#  evening    :integer          default(0)
#  late_night :integer          default(0)
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
class Dose < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  belongs_to :user
  has_many :logs, dependent: :nullify

  validates :evening, :morning, :afternoon, :night, :late_night, numericality: { greater_than: 0, less_than: 150 },
                                                                 on: :update

  before_save :validate_active_doses
  after_save :enable_default_dose

  private

  def validate_active_doses
    user.doses.active.update(status: 'inactive') if active? && id.present?
  end

  def enable_default_dose
    user.doses.last.active! if user.active_dose.blank?
  end
end
