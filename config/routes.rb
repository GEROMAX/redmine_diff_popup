Rails.application.routes.draw do
  get 'diff_popup/journal_diff', to: 'diff_popup#journal_diff'
  match 'wiki_popup/:action', :controller => 'wiki_popup', :via => [:get]
end
