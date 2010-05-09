require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#complement' do
  subject { equality.complement }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:equality)  { attribute.eq(1)             }

  it { should eql(attribute.ne(1)) }

  it 'is reversible' do
    subject.complement.should eql(equality)
  end
end
