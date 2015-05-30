class Version < ActiveRecord::Base
  # updated_at of Page will be updated when new version is saved
  belongs_to :page, touch: true

  after_save do
    touch
  end

  validates_presence_of :page_id
  validates_presence_of :body, message: "body can't be blank"

  # query syntax: http://groonga.org/ja/docs/reference/grn_expr/query_syntax.html
  scope :full_text_search, ->(query) { where("body @@ ?", query) }
  scope :latests, -> () { where("versions.created_at = (SELECT max(created_at) FROM versions i WHERE i.page_id = versions.page_id)") }

  def first_n_lines(n)
    body.split(/\r?\n/)[0,n].join("\n")
  end

  def find_index
    page.versions.find_index(self)
  end
end
