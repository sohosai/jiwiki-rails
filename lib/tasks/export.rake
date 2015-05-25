namespace :export do
  desc "exports posts"

  task json: :environment do
    puts(Page.all.map do |page|
      {
        title: page.title,
        page_slug: page.page_slug,
        tags: page.tags,
        created_at: page.versions.first.created_at,
        updated_at: page.updated_at,
        versions: page.versions.map { |ver| {
          body: ver.body,
          created_at: ver.created_at
        }}
      }
    end.to_json)
  end
end
