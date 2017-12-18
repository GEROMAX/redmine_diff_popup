class DiffPopupHook < Redmine::Hook::ViewListener
  render_on :view_issues_history_journal_bottom, :partial => 'issues/issues_history_journal_bottom_partial'
  render_on :view_issues_show_details_bottom, :partial => 'issues/issues_show_details_bottom_partial'
  render_on :view_my_account_preferences, :partial => 'my/diff_popup_preferences'

  def view_layouts_base_html_head(context={})
    if is_wiki_history?(context[:request])
      context[:controller].send(:render_to_string, {
        :partial => 'layouts/wiki_popup_html_head_partial',
        :locals => context
      })
    end
  end

  def view_layouts_base_content(context={})
    if is_wiki_history?(context[:request])
      context[:controller].send(:render_to_string, {
        :partial => 'layouts/wiki_popup_content_partial',
        :locals => context
      })
    end
  end

private
  def is_wiki_history?(request)
    request.original_url =~ Regexp.new('/projects/\S+/wiki/\S+/history$')
  end
  
end
