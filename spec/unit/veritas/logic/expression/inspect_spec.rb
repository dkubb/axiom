require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#inspect' do
  let(:expression) { ExpressionSpecs::Object.new }

  subject { expression.inspect }

  specify { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#inspect must be implemented') }
end
