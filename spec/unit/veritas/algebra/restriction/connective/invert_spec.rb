require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Connective#invert' do
  before do
    @connective = ConnectiveSpecs::Object.new
  end

  subject { @connective.invert }

  it 'should negate the connective' do
    should eql(Algebra::Restriction::Negation.new(@connective))
  end

  it 'should invert back to original' do
    subject.invert.should eql(@connective)
  end
end
