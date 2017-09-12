require_dependency 'redmine_diff_popup/hooks/diff_popup_hook'
require_dependency 'redmine_diff_popup/patches/issues_helper_patch'
require_dependency 'redmine_diff_popup/patches/user_preference_patch'


ActionDispatch::Callbacks.to_prepare do
  unless UserPreference.included_modules.include?(RedmineDiffPopup::Patches::UserPreferencePatch)
    UserPreference.send :prepend, RedmineDiffPopup::Patches::UserPreferencePatch
  end
  
  unless IssuesHelper.included_modules.include?(RedmineDiffPopup::Patches::IssuesHelperPatch)
    IssuesHelper.send :prepend, RedmineDiffPopup::Patches::IssuesHelperPatch
  end
end


Redmine::Plugin.register :redmine_diff_popup do
  name 'Redmine Diff Popup plugin'
  author 'Ryuta Tobita'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/GEROMAX/redmine_diff_popup'
  author_url 'https://github.com/GEROMAX'
end
