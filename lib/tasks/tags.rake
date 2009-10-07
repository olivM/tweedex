namespace :tags do
  
  desc "fetch new tweets"
  task :fetch => :environment do

    3.times do
      Tag.fetch
    end
    
    Tag.update_stats

    Tweet.destroy_all(" published_at < '#{1.day.ago}' ")
  
  end
  
  desc "import"
  task :import => :environment do

    Panel.import_all
  
  end
  
  desc "init"
  task :init => :environment do

    Panel.destroy_all
    Panel.import_all
    
    3.times do
      Tag.fetch
    end
    
    Tag.update_stats

    Tweet.destroy_all(" published_at < DATE_ADD(NOW(), INTERVAL -1 DAY) ")
    
  end
  
end