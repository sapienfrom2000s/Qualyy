guard :rspec, cmd: 'bundle exec rspec' do
  watch('spec/spec_helper.rb')                        { 'spec' }
  watch(%r{^spec/(support/factory_bot|factories/factories).rb$}) {'spec/system'}
  watch('config/initializers/string_utils.rb')        { 'spec/models/string_utils_spec.rb' }
  watch('app/models/youtube.rb')                      { 'spec/models/youtube_spec.rb' }
  watch(%r{^app\/(.*)\/(.*\.erb)$})                   { |m| "spec/system/#{m[1]}_spec.rb" }
  watch(%r{^app\/controllers\/(.*)_controller.rb$})   { |m| "spec/system/#{m[1]}_spec.rb" }
end
