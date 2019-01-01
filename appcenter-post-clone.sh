# This fixes build problems on App Center (an xcodebuild error 65 to be specific)
gem install cocoapods --pre

# Install cocoapods keys on App Center, then use env vars in the build config to set the keys
gem install cocoapods-keys