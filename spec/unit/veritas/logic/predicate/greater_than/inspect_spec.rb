require 'spec_helper'

describe 'Veritas::Logic::Predicate::GreaterThan#inspect' do
  subject { greater_than.inspect }

  let(:attribute)    { Attribute::Integer.new(:id) }
  let(:greater_than) { attribute.gt(1)             }

  it { should == "#{attribute.inspect} > 1" }
end
