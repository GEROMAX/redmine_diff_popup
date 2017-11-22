Rails.application.routes.draw do
  get 'diff_popup/journal_diff', to: 'diff_popup#journal_diff'
  get 'diff_popup/wiki_diff', to: 'diff_popup#wiki_diff'
end
