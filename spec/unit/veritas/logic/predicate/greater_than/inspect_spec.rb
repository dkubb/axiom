require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThan#inspect' do
  let(:attribute)    { Attribute::Integer.new(:id) }
  let(:greater_than) { attribute.gt(1)             }

  subject { greater_than.inspect }

  it { should == "#{attribute.inspect} > 1" }
end
