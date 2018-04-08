target 'Stakeout' do
  use_frameworks!
  
  pod 'TwitterKit', '<3.3.0' # probably 3.2.2
  pod 'TwitterCore', '<3.1.0' # probably 3.0.3

  pod 'Swifter', :git => 'https://github.com/mattdonnelly/Swifter.git', :tag => '2.1.0'

  plugin 'cocoapods-keys', {
  :project => "Stakeout",
  :keys => [
    "TwitterConsumerKey",
    "TwitterConsumerSecret"
  ]}

  target 'StakeoutTests' do
    inherit! :search_paths
  end
  
end

post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-Stakeout/Pods-Stakeout-acknowledgements.plist', 'Stakeout/Other/Settings.bundle/Code-Acknowledgements.plist', :remove_destination => true)
end
