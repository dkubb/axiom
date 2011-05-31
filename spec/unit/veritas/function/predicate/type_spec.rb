# encoding: utf-8

require 'spec_helper'

describe Function::Predicate, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Predicate)   }
  let(:object)          { described_class.new(left, right) }
  let(:left)            { mock('Left')                     }
  let(:right)           { mock('Right')                    }

  it { should equal(Attribute::Boolean) }
end
