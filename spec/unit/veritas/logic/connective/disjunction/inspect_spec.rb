require 'spec_helper'

describe 'Veritas::Logic::Connective::Disjunction#inspect' do
  subject { object.inspect }

  let(:klass)     { Logic::Connective::Disjunction }
  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:left)      { attribute.gt(1)                }
  let(:right)     { attribute.lt(3)                }
  let(:object)    { klass.new(left, right)         }

  it { should == "(#{left.inspect} OR #{right.inspect})"}
end
