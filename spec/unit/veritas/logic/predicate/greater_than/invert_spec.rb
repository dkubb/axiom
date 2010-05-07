require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan#invert' do
  subject { greater_than.invert }

  let(:attribute)    { Attribute::Integer.new(:id) }
  let(:greater_than) { attribute.gt(1)             }

  it { should eql(attribute.lte(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(greater_than)
  end
end
