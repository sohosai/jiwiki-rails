class Page
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  include Mongoid::Slug

  field :slug, type: String
  field :title, type: String
  field :is_deleted, type: Mongoid::Boolean

  has_many :versions, autosave: true
  validates_uniqueness_of :slug

  slug :slug

  # virtual attribute to handle create: content of page's initial version
  attr_accessor :body

  def last_edited_at
    versions.last.created_at
  end

  def to_param
    slug
  end
end
