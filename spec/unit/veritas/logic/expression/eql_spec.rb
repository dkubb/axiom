require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Expression#eql?' do
  before do
    @other = ExpressionSpecs::Object.new

    @expression = ExpressionSpecs::Object.new
  end

  subject { @expression == @other }

  it { method(:subject).should raise_error(NotImplementedError, 'ExpressionSpecs::Object#eql? must be implemented') }
end
