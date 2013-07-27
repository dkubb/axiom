# encoding: utf-8

require 'spec_helper'

describe Function::Predicate, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Function::Predicate)   }
  let(:object)          { described_class.new(left, right) }
  let(:left)            { double('Left')                   }
  let(:right)           { double('Right')                  }

  it { should be(Attribute::Boolean) }
end
