$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

SUPPORT_DIR = File.join(__dir__, 'support')
Dir[File.join(SUPPORT_DIR, '/**/*.rb')].each { |file| require file }
