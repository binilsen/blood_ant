# frozen_string_literal: true

class ApplicationQuery
  attr_accessor :records, :params

  def initialize(records, params)
    @records = records
    @params = params
  end

  def self.perform(records, params)
    new(records, params).resolve
  end
end
