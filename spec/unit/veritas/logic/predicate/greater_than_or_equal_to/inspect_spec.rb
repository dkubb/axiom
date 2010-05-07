require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo#inspect' do
  subject { greater_than_or_equal_to.inspect }

  let(:attribute)                { Attribute::Integer.new(:id) }
  let(:greater_than_or_equal_to) { attribute.gte(1)            }

  it { should == "#{attribute.inspect} >= 1" }
end
