require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Expression#==' do
  before do
    @other = ExpressionSpecs::Object.new

    # so the with(@other) below can match successfully
    def @other.eql?(other)
      equal?(other)
    end

    @expression = ExpressionSpecs::Object.new
  end

  subject { @expression == @other }

  it 'should delegate to #eql?' do
    result = mock('result')
    @expression.should_receive(:eql?).with(@other).and_return(result)
    subject.should equal(result)
  end
end
