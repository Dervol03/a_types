$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'a_types'

require 'a_types/core_ext/all'

SUPPORT_DIR = File.join(__dir__, 'support')
Dir[File.join(SUPPORT_DIR, '/**/*.rb')].each{ |file| require file }