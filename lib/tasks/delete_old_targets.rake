task :delete_old_targets => :environment do
  Target.a_week_ago.each do |target|
    target.destroy
  end
end
