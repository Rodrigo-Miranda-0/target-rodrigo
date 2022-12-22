require 'rails_helper'

Rails.application.load_tasks

describe 'delete_old_targets.rake', type: :task do
  let!(:old_target) { create(:target, created_at: 2.weeks.ago) }
  let!(:new_target) { create(:target) }

  it 'deletes old targets' do
    Rake::Task['delete_old_targets'].invoke
    expect(Target.first).to eq(new_target)
    expect(Target.count).to eq(1)
  end
end
