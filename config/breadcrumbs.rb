crumb :root do
  link "JiWiki", root_path
end

crumb :pages do
  link "All pages", Page
end

crumb :page do |page|
  link page.title, show_page_path(page)
  parent :pages
end

crumb :new_page do
  link "New page"
  parent :pages
end

crumb :version do |version|
  link version.title, version_path(version)
  parent :page, version.page
end

crumb :search do |query|
  link "Search: #{query}"
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
