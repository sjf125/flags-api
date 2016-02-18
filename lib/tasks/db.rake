namespace :db do
  desc "Load example data from db/examples.rb"
  task examples: :environment do
    require_relative '../../db/examples'
  end

  unless Rails.env == "production"
    desc "Re-populate the development database"
    task populate: %w(environment db:drop db:create db:migrate db:seed db:examples) do
      puts "Nuke and pave of #{Rails.env} complete."
    end
  end
end
