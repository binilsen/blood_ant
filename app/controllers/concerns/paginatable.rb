# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern
  include Pagy::Backend
  def paginate(records)
    # paginate as usual with any pagy_* backend constructor
    pagy, collection = pagy(records)
    # explicitly merge the headers to the response
    pagy_headers_merge(pagy)
    collection
  end
end
