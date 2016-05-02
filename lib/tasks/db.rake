require 'csv'

namespace :db do
  namespace :populate do
    desc 'Fill the database with example data'
    task all: [:flags]

    desc 'Fill the people table with example data'
    task flags: :environment do
      # Flag.transaction do
      #   CSV.foreach(Rails.root + 'data/flags.csv',
      #               headers: true) do |flag_row|
      #     flag = flag_row.to_hash
      #     next if Flag.exists? flag
      #     Flag.create!(flag)
      #   end
      # end
    end
  end
  desc 'Load example data from db/examples.rb'
  task examples: :environment do
    require_relative '../../db/examples'
  end

  unless Rails.env == 'production'
    desc 'Drop and setup the development database with examples'
    task nuke_pave:
      %w(environment db:drop db:create db:migrate db:seed db:examples) do
      puts "Nuke and pave of #{Rails.env} complete."
    end
  end
end
