class Version
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :body, type: String

  belongs_to :page
end
