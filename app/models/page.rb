class Page
  include Mongoid::Document
  include Mongoid::Slug

  field :slug, type: String
  field :title, type: String
  field :is_deleted, type: Mongoid::Boolean

  has_many :versions, autosave: true
  validates_uniqueness_of :slug

  slug :slug

  def body
  end

  def last_edited_at
    versions.last.created_at
  end
end
