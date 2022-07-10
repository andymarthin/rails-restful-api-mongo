class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :detail, type: String
end
