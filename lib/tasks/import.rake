namespace :import do
  desc "imports posts"

  task :json, [:file] => :environment do |task, args|
    input = open(args[:file]).read
    json = JSON.parse input

    json.each do |post|
      page = Page.create(
        title: post["title"],
        page_slug: post["page_slug"],
        created_at: Time.parse(post["created_at"]),
        updated_at: Time.parse(post["updated_at"]),
      )
      page.tag_list.add(*post["tags"])
      page.save
      post["versions"].each do |ver|
        Version.create(
          body: ver["body"],
          created_at: Time.parse(ver["created_at"]),
          page: page
        )
      end
    end
  end
end
