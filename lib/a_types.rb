require 'a_types/version'

support_dir = File.join(__dir__, 'a_types/support')
Dir[File.join(support_dir, '/**/*.rb')].each do |support_file|
  require support_file
end

# Provides different convenience decorators following the decorator pattern.
module ATypes
end
