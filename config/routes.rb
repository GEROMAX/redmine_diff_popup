Rails.application.routes.draw do
  get 'diff_popup/journal_diff', to: 'diff_popup#journal_diff'
  get 'wiki_popup/wiki_diff', to: 'wiki_popup#wiki_diff'
end
