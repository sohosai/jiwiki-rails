class Version
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Search
  field :body, type: String

  # updated_at of Page will be updated when new version is saved
  belongs_to :page, touch: true
  after_save do
    touch
  end

  search_in :body

  def first_n_lines(n)
    body.split(/\r?\n/)[0,n].join("\n")
  end
end
