class DiffPopupHook < Redmine::Hook::ViewListener
  render_on :view_issues_history_journal_bottom, :partial => 'issues/issues_history_journal_bottom_partial'
  render_on :view_issues_show_details_bottom, :partial => 'issues/issues_show_details_bottom_partial'
  #render_on :view_layouts_base_html_head, :partial => 'layouts/wiki_popup_html_head_partial'
  #render_on :view_layouts_base_body_bottom, :partial => 'layouts/wiki_popup_body_bottom_partial'
  render_on :view_my_account_preferences, :partial => 'my/diff_popup_preferences'

  def view_layouts_base_content(context={})
    if isWikiPage?
      context[:controller].send(:render_to_string, {
        :partial => "layouts/wiki_popup_content_partial",
        :locals => context
      })
    end
  end

  private
  def isWikiPage?
    request.request_uri =~ Regexp.new("projects\/*\w+\/wiki\/*[A-Za-z0-9_\%]+\/history")
  end
  
end
