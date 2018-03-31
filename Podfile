target 'Tweet Monitor' do
  use_frameworks!

  pod 'TwitterKit'
  pod 'Swifter', :git => 'https://github.com/mattdonnelly/Swifter.git', :tag => '2.1.0'

  plugin 'cocoapods-keys', {
  :project => "Tweet Monitor",
  :keys => [
    "TwitterConsumerKey",
    "TwitterConsumerSecret"
  ]}

  target 'Tweet MonitorTests' do
    inherit! :search_paths
  end

end
