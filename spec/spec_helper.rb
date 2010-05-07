$LOAD_PATH.unshift(File.expand_path('../', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'rubygems'
require 'backports'
require 'veritas'
require 'spec'
require 'spec/autorun'

include Veritas

# require spec support files
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

Spec::Runner.configure do |config|
end
