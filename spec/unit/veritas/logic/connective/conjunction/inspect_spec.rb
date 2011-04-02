require 'spec_helper'

describe Logic::Connective::Conjunction, '#inspect' do
  subject { object.inspect }

  let(:attribute) { Attribute::Integer.new(:id)      }
  let(:left)      { attribute.gt(1)                  }
  let(:right)     { attribute.lt(3)                  }
  let(:object)    { described_class.new(left, right) }

  it { should == "(#{left.inspect} AND #{right.inspect})" }
end
