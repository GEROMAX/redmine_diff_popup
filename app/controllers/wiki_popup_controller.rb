require 'htmldiff'

class WikiPopupController < ApplicationController
  unloadable
  before_action :find_wiki, :authorize
  before_action :find_existing_page, :only => [:wiki_diff]

  layout false

  def wiki_diff
    @diff = @page.diff(params[:version], params[:version_from])

    render_404 unless @diff

    # change start,tplink,guishaoli
    # 获取需要对比的俩个版本号
    version_to = params[:version]
    version_from = params[:version_from]
    version_to = version_to ? version_to.to_i : @page.content.version
    content_to = @page.content.versions.find_by_version(version_to)
    content_from = version_from ? @page.content.versions.find_by_version(version_from.to_i) : content_to.try(:previous)

    # 保证是大版本对比小版本
    if content_from.version > content_to.version
      content_to, content_from = content_from, content_to
    end

    # 使用edouard-htmldiff进行比较
    @diff_result = HTMLDiff.diff(content_from.text,content_to.text,true)
    @left = @diff_result[0].gsub("diffmod","diff_out").gsub("difftype","class").gsub("diffdel","diff_out")
    @right = @diff_result[1].gsub("diffmod","diff_in").gsub("difftype","class").gsub("diffins","diff_in")
    # change end
  end

private

  def find_wiki
    @project = Project.find(params[:project_id])
    @wiki = @project.wiki
    render_404 unless @wiki
  rescue ActiveRecord::RecordNotFound
    render_404
  end

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

  def redirect_to_page(page)
    if page.project && page.project.visible?
      redirect_to :action => action_name, :project_id => page.project, :id => page.title
    else
      render_404
    end
  end

end
