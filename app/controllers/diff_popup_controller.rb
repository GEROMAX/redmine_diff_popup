class DiffPopupController < ApplicationController
  unloadable
  before_action :find_journal, :only => [:journal_diff]

  layout false
  helper :issues
  helper :custom_fields

  def journal_diff
    @issue = @journal.issue
    if params[:detail_id].present?
      @detail = @journal.details.find_by_id(params[:detail_id])
    else
      @detail = @journal.details.detect {|d| d.property == 'attr' && d.prop_key == 'description'}
    end
    unless @issue && @detail
      render_404
      return false
    end
    if @detail.property == 'cf'
      unless @detail.custom_field && @detail.custom_field.visible_by?(@issue.project, User.current)
        raise ::Unauthorized
      end
    end
    @diff = Redmine::Helpers::Diff.new(@detail.value, @detail.old_value)
  end

  private

  def find_journal
    @journal = Journal.visible.find(params[:id])
    @project = @journal.journalized.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
