# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::Enumerable, '#call' do
  subject { object.call(tuple) }

  let(:described_class) { Class.new(Function) { include Function::Binary } }
  let(:header)          { Relation::Header.coerce([[:id, Integer]])        }
  let(:tuple)           { Tuple.new(header, [1])                           }

  before do
    described_class.class_eval { include Function::Predicate::Enumerable }
  end

  context 'with an enumerable of non-callable objects' do
    let(:object) { described_class.new(header[:id], [1]) }

    it 'sends the left and right value to self.class.call' do
      response = double('#call response')
      described_class.should_receive(:call).with(1, [1]).and_return(response)
      should equal(response)
    end
  end

  context 'with an enumerable of callable objects' do
    let(:callable) { proc { 1 }                                   }
    let(:object)   { described_class.new(header[:id], [callable]) }

    it 'sends the left and right value to self.class.call' do
      response = double('#call response')
      described_class.should_receive(:call).with(1, [1]).and_return(response)
      should equal(response)
    end
  end
end
