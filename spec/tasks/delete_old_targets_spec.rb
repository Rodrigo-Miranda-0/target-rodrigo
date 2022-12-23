require 'rails_helper'

Rails.application.load_tasks

describe 'delete_old_targets.rake', type: :task do
  subject { Rake::Task['delete_old_targets'].invoke }

  let!(:old_target) { create(:target, created_at: 2.weeks.ago) }
  let!(:new_target) { create(:target) }

  it 'deletes old targets' do
    expect { subject }.to change(Target, :count).by(-1)
  end
end
