# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate, '#call' do
  subject { object.call(tuple) }

  let(:object) { described_class.new(header[:id], 1)       }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:tuple)  { Tuple.new(header, [1])                    }

  it 'sends the left and right value to self.class.call' do
    response = double('#call response')
    expect(described_class).to receive(:call).with(1, 1).and_return(response)
    should be(response)
  end
end
