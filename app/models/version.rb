class Version
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Search

  field :body, type: String
  field :title, type: String

  # updated_at of Page will be updated when new version is saved
  embedded_in :page, touch: true
  after_save do
    touch
  end

  validates_presence_of :page_id
  validates_presence_of :body, message: "body can't be blank"
  validates_presence_of :title, message: "title can't be blank"

  search_in :body, :title

  def first_n_lines(n)
    body.split(/\r?\n/)[0,n].join("\n")
  end

  def find_index
    page.versions.find_index(self)
  end
end
