$LOAD_PATH.unshift(File.expand_path('../', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'backports'
require 'veritas'
require 'spec'
require 'spec/autorun'

include Veritas

Spec::Runner.configure do |config|
end
