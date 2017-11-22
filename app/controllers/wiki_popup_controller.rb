class WikiPopupController < ApplicationController
  unloadable
  default_search_scope :wiki_pages
  before_filter :find_existing_page, :only => [:wiki_diff]

  layout false
  helper :issues
  helper :custom_fields

  def wiki_diff
    @diff = @page.diff(params[:version], params[:version_from])
    render_404 unless @diff
  end

  # def journal_diff
  #   @issue = @journal.issue
  #   if params[:detail_id].present?
  #     @detail = @journal.details.find_by_id(params[:detail_id])
  #   else
  #     @detail = @journal.details.detect {|d| d.property == 'attr' && d.prop_key == 'description'}
  #   end
  #   unless @issue && @detail
  #     render_404
  #     return false
  #   end
  #   if @detail.property == 'cf'
  #     unless @detail.custom_field && @detail.custom_field.visible_by?(@issue.project, User.current)
  #       raise ::Unauthorized
  #     end
  #   end
  #   @diff = Redmine::Helpers::Diff.new(@detail.value, @detail.old_value)
  # end

private

  # Finds the requested page and returns a 404 error if it doesn't exist
  def find_existing_page
    @page = @wiki.find_page(params[:id])
    if @page.nil?
      render_404
      return
    end
    if @wiki.page_found_with_redirect?
      redirect_to_page @page
    end
  end

end
