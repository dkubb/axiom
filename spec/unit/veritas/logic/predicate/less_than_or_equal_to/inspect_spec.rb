require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#inspect' do
  subject { less_than_or_equal_to.inspect }

  let(:attribute)             { Attribute::Integer.new(:id) }
  let(:less_than_or_equal_to) { attribute.lte(1)            }

  it { should == "#{attribute.inspect} <= 1" }
end
