task :delete_old_targets => :environment do
  Target.where('created_at < ?', 1.week.ago).each do |target|
    target.destroy
  end
end
