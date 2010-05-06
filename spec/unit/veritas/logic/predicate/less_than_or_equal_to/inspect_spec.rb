require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::LessThanOrEqualTo#inspect' do
  let(:attribute)             { Attribute::Integer.new(:id) }
  let(:less_than_or_equal_to) { attribute.lte(1)            }

  subject { less_than_or_equal_to.inspect }

  it { should == "#{attribute.inspect} <= 1" }
end
