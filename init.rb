require_dependency 'diff_popup_hook'
require_dependency 'diff_popup_helper_patch'

Redmine::Plugin.register :redmine_diff_popup do
  name 'Redmine Diff Popup plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
