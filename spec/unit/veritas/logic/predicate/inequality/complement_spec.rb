require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#complement' do
  subject { inequality.complement }

  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  it { should eql(attribute.eq(1)) }

  it 'is reversible' do
    subject.complement.should eql(inequality)
  end
end
