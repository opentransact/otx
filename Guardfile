guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  watch('otx.rb') { "spec"}
  watch(/^models\/(.*)\.rb/)                          { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
end
