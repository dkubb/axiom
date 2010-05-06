require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Connective::Disjunction#inspect' do
  let(:attribute)   { Attribute::Integer.new(:id)                     }
  let(:left)        { attribute.gt(1)                                 }
  let(:right)       { attribute.lt(3)                                 }
  let(:disjunction) { Logic::Connective::Disjunction.new(left, right) }

  subject { disjunction.inspect }

  it { should == "(#{left.inspect} OR #{right.inspect})"}
end
