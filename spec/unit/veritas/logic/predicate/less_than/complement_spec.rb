require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan#complement' do
  subject { less_than.complement }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:less_than) { attribute.lt(1)             }

  it { should eql(attribute.gte(1)) }

  it 'is reversible' do
    subject.complement.should eql(less_than)
  end
end
