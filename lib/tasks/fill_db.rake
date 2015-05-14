namespace :fill_db do
  desc "generate random posts and save them to db"

  task random: :environment do
    pn = PetName::Generator.new

    def random_mkd(pn)
      %{
# #{pn.generate separator: " ", words: 6}

#{pn.generate separator: " ", words: 100}

link: [Google](https://www.google.com/) and [Yahoo!](https://www.yahoo.com/)

- hoge
- fuga
  - 2nd level piyo
    - 3rd level foobar
- emoji :clap:

1. numbered
1. ordered
  1. also 2nd level
    1. yeah also 3rd level
1. foooo

```ruby
# code here!
class Version
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Search

  field :body, type: String
  field :title, type: String

  # updated_at of Page will be updated when new version is saved
  belongs_to :page, touch: true
  after_save do
    touch
  end

  validates_presence_of :page_id
  validates_presence_of :body, message: "body can't be blank"
  validates_presence_of :title, message: "title can't be blank"

  search_in :body, :title

  def first_n_lines(n)
    body.split(/\\r?\\n/)[0,n].join("\\n")
  end
end
```

## #{pn.generate separator: " ", words: 10}

#{pn.generate separator: " ", words: 100}

### #{pn.generate separator: " ", words: 10}

#{pn.generate separator: " ", words: 100}

#### #{pn.generate separator: " ", words: 10}

#{pn.generate separator: " ", words: 100}

##### #{pn.generate separator: " ", words: 10}

#{pn.generate separator: " ", words: 100}

###### #{pn.generate separator: " ", words: 10}

#{pn.generate separator: " ", words: 100}
      }
    end

    (0..100).each do |i|
      title = pn.generate separator: " ", words: 5
      page = Page.create(
        title: title,
        tags: title.split,
        page_slug: title.gsub(/\s/, '-')
      )
      (0..(rand(9) + 1)).each do |v|
        ver = Version.create(body: random_mkd(pn), title: title)
        page.versions << ver
      end
      page.save
    end
  end
end
