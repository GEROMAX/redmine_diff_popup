require_dependency("issues_helper")

module RedmineDiffPopup
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

      # add method to IssuesHelper
      def is_show_diff_detail?(detail)
        case detail.property
        when 'attr'
          return detail.prop_key == 'description'
        when 'cf'
          custom_field = detail.custom_field
          if custom_field
            if custom_field.format.class.change_as_diff
              return true
            end
          end
        end
        return false
      end

      def show_detail_diff_popup(detail, indice)
        label = detail.prop_key == 'description' ? l(:field_description) : detail.custom_field.name
        label = content_tag('strong', label)
        s = l(:text_journal_changed_no_detail, :label => label)
        diff_link = link_to 'diff',
          diff_popup_journal_diff_url(:id => detail.journal_id, :detail_id => detail.id, :indice => indice),
          :title => l(:label_view_diff),
          :onclick => 'return false;'
        s << " (#{ diff_link })"
        s.html_safe
      end

    end
  end
end
