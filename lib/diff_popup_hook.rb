class DiffPopupHook < Redmine::Hook::ViewListener
  render_on :view_issues_history_journal_bottom, :partial => 'issues/issues_history_journal_bottom_partial'
  render_on :view_issues_show_details_bottom, :partial => 'issues/issues_show_details_bottom_partial'
  render_on :view_my_account_preferences, :partial => 'my/diff_popup_preferences'
end
