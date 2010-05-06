require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThan#inspect' do
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:less_than) { attribute.lt(1)             }

  subject { less_than.inspect }

  it { should == "#{attribute.inspect} < 1" }
end
