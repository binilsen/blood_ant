# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogReportJob, type: :job do
  include ActiveJob::TestHelper
  let(:user) { create(:user) }
  let!(:logs) { create_list(:log, 3, created_at: 1.month.ago, user:) }
  let(:params) { { month: '3' } }

  subject(:job) { described_class.perform_later(user.id, params) }

  it 'queues the job' do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'it is in default queue' do
    expect(LogReportJob.new.queue_name).to eq('default')
  end
end
