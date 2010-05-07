require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#invert' do
  subject { equality.invert }

  let(:attribute) { Attribute::Integer.new(:id) }
  let(:equality)  { attribute.eq(1)             }

  it { should eql(attribute.ne(1)) }

  it 'inverts back to original' do
    subject.invert.should eql(equality)
  end
end
