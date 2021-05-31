class ImportClusterJob < ApplicationJob
  sidekiq_options queue: :import

  def perform(users)
    batch = Sidekiq::Batch.new
    batch.description = "Batch description (this is optional)"
    batch.on(:success, ImportClusterJob::ImportCallback, { row_count: users.count })
    batch.jobs do
      users.each do |user|
        UserImportJob.perform_async(user['name'], user['cpf'])
      end
    end
    puts "Just started Batch #{batch.bid}"
  end
  class ImportCallback
    def on_success(status, options)
      puts status, options
    end
  end
end
