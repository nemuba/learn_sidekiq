require 'csv'

namespace :generate_user do
  desc 'User - import 10_000 users'
  task :import => :environment do
    file = './tmp/user_export_2021-05-29 23:08:34 -0300.csv'

    CSV.foreach(file, col_sep: ',', headers: false) do |user|
      UserImportJob.perform_async(user[0], user[1])
    end
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
