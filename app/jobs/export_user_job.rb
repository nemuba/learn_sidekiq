require 'csv'

class ExportUserJob < ApplicationJob
  sidekiq_options queue: :export

  def perform(limit)
    users = User.limit(limit)

    file_name = "./tmp/user_export_#{Time.now}.csv"

    CSV.open(file_name, 'wb+') do |csv|
      csv << ['Nome', 'CPF']
      users.each do |user|
        csv << [user.name, user.cpf]
      end
    end
  end
end
