require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan#invert' do
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:less_than) { attribute.lt(1)             }

  subject { less_than.invert }

  it { should eql(attribute.gte(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(less_than)
  end
end
