require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Equality#inspect' do
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:equality)  { attribute.eq(1)             }

  subject { equality.inspect }

  it { should == "#{attribute.inspect} == 1" }
end
