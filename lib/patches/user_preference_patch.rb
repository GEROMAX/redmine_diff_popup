require_dependency 'user_preference'

module RedmineDiffPopup
  module Patches
    module UserPreferencePatch

      def self.prepended(base)
        base.class_eval do
          if defined? safe_attributes
            safe_attributes :enable_popup_journal_diff
          end
        end
      end

      def enable_popup_journal_diff; self[:enable_popup_journal_diff] || '1'; end
      def enable_popup_journal_diff=(value); self[:enable_popup_journal_diff]=value; end

    end
  end
end
