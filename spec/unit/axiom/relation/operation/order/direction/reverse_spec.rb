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
    allow(described_class).to receive(:reverse).and_return(reverse_class)
  end

  it 'calls .reverse on the class' do
    expect(described_class).to receive(:reverse).with(no_args)
    subject
  end

  it 'calls .new on the reverse class' do
    expect(reverse_class).to receive(:new).with(attribute)
    subject
  end

  it { should be(reverse) }
end
