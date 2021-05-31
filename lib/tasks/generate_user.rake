require 'csv'

namespace :generate_user do
  desc 'User - import 10_000 users'
  task :import => :environment do
    users = get_users(10_000)

    ImportClusterJob.perform_async(users)
  end

  desc 'User - export'
  task :generate => :environment do
    ExportUserJob.perform_async(100_000)
  end

  def get_users(value = 1)
    users = []
    value.times do |_u|
      users << {
        name: Faker::Name.name,
        cpf: Faker::Number.number(digits: 11).to_s
      }
    end

    users
  end
end
