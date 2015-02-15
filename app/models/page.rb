class Page
  include Mongoid::Document
  field :slug, type: String
  field :title, type: String
  field :is_deleted, type: Mongoid::Boolean
end
