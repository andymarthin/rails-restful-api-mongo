class ArticleSerializer
  include JSONAPI::Serializer
  attributes :title, :detail
end
