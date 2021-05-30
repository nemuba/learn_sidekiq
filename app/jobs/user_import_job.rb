class UserImportJob < ApplicationJob
  sidekiq_options queue: :import

  def perform(name, cpf)
    User.create!(name: name, cpf: cpf)
  end
end
