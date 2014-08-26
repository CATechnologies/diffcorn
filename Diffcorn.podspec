Pod::Spec.new do |s|
  s.name = 'Diffcorn'
  s.version = '0.2'
  s.platform = :ios, '7.0'
  s.license = 'MIT'
  s.summary = 'JSONDiff interpreter and with a persistent module'
  s.homepage = 'https://github.com/teambox/Diffcorn'
  s.author = { 'Redbooth' => 'team@redbooth.com' }
  s.source = { :git => 'https://github.com/teambox/Diffcorn', :tag => '0.2' }
  s.description = <<-DESC
  Diffcorn makes easier the implementation of JSONDiff in your app, reading the API responses and translating them into an input message for a persistent entity. It even persists the 'updated_at' related to a given request
                    DESC
  s.requires_arc = true
  s.source_files = 'Diffcorn/*.{h,m}'
  s.public_header_files = 'Diffcorn/*.h'
end