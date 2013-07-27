# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Direction, '#reverse' do
  subject { object.reverse }

  let(:described_class) { Class.new(Relation::Operation::Order::Direction) }
  let(:attribute)       { Attribute::Integer.new(:id)                      }
  let(:reverse_class)   { double('Reverse Class', new: reverse)            }
  let(:reverse)         { double('Reverse Instance')                       }
  let(:object)          { described_class.new(attribute)                   }

  before do
    described_class.stub(reverse: reverse_class)
  end

  it 'calls .reverse on the class' do
    described_class.should_receive(:reverse).with(no_args)
    subject
  end

  it 'calls .new on the reverse class' do
    reverse_class.should_receive(:new).with(attribute)
    subject
  end

  it { should be(reverse) }
end
