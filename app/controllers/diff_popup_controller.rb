require 'htmldiff'
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

    # change start,tplink,guishaoli
    # 使用edouard-htmldiff对issue的修改前后的内容进行diff
    @diff_result = HTMLDiff.diff(@detail.old_value,@detail.value,true)
    # 将原生的diffmod（修改）diffdel（删除） diffins（增加）替换成redmine的class
    @left = @diff_result[0].gsub("diffmod","diff_out").gsub("difftype","class").gsub("diffdel","diff_out")
    @right = @diff_result[1].gsub("diffmod","diff_in").gsub("difftype","class").gsub("diffins","diff_in")
    # change end
  end

private

  def find_journal
    @journal = Journal.visible.find(params[:id])
    @project = @journal.journalized.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
