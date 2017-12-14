class DiffPopupHook < Redmine::Hook::ViewListener
  render_on :view_issues_history_journal_bottom, :partial => 'issues/issues_history_journal_bottom_partial'
  render_on :view_issues_show_details_bottom, :partial => 'issues/issues_show_details_bottom_partial'
  render_on :view_layouts_base_html_head, :partial => 'layouts/wiki_popup_html_head_partial'
  render_on :view_layouts_base_body_bottom, :partial => 'layouts/wiki_popup_body_bottom_partial'
  render_on :view_my_account_preferences, :partial => 'my/diff_popup_preferences'
end
