Pod::Spec.new do |s|
s.name         = "NKScripting"
s.version      = "0.9.1"
s.summary      = "The universal, open-source, embedded engine"
s.description  = "NodeKit is the universal, open-source, embedded engine that provides a full ES5 / Node.js instance inside desktop and mobile applications for OS X, iOS, Android, and Windows."
s.homepage     = "https://github.com/nodekit-io/nodekit"
s.license      = { :type => 'APACHE-2', :file => 'LICENSE' }
s.author       = { "OffGrid Networks" => 'admin@offgridn.com' }
s.source       = { :git => "https://github.com/nodekit-io/nodekit-darwin.git" }

s.ios.deployment_target = '9.3'
s.osx.deployment_target = '10.11'

s.source_files = "src/nodekit", "src/nodekit/**/*.{swift,h,m}"
s.requires_arc = true
end