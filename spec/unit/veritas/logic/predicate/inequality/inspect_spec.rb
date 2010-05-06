require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inequality#inspect' do
  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  subject { inequality.inspect }

  it { should == "#{attribute.inspect} != 1" }
end
