class DiffPopupHook < Redmine::Hook::ViewListener
  render_on :view_issues_history_journal_bottom, :partial => 'issues/issues_history_journal_partial'
#  render_on :view_my_account_preferences, :partial => 'my/subtask_list_accordion_preferences'
end
