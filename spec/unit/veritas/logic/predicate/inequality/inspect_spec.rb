require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inequality#inspect' do
  subject { inequality.inspect }

  let(:attribute)  { Attribute::Integer.new(:id) }
  let(:inequality) { attribute.ne(1)             }

  it { should == "#{attribute.inspect} != 1" }
end
