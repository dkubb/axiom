require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo#invert' do
  subject { greater_than_or_equal_to.invert }

  let(:attribute)                { Attribute::Integer.new(:id) }
  let(:greater_than_or_equal_to) { attribute.gte(1)            }

  it { should eql(attribute.lt(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(greater_than_or_equal_to)
  end
end
