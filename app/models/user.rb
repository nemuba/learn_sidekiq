class User
  include Mongoid::Document
  
  field :name, type: String
  field :cpf, type: String

  index(name: 1)
  index(cpf: 1)
end
