json.array!(@pages) do |page|
  json.extract! page, :id, :slug, :title, :is_deleted
  json.url page_url(page, format: :json)
end
