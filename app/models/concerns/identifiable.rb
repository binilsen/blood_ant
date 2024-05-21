# frozen_string_literal: true

module Identifiable
  extend ActiveSupport::Concern

  included do
    before_create :generate_ulid
  end

  def generate_ulid
    return unless has_attribute?(:ulid)

    self.ulid = ULID.generate
  end
end
