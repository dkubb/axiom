require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::GreaterThanOrEqualTo#inspect' do
  let(:attribute)                { Attribute::Integer.new(:id) }
  let(:greater_than_or_equal_to) { attribute.gte(1)            }

  subject { greater_than_or_equal_to.inspect }

  it { should == "#{attribute.inspect} >= 1" }
end
