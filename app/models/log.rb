class Log
  include Mongoid::Document
  field :file_name, type: String
  field :status, type: Symbol
end
