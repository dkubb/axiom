# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted::Direction, '#call' do
  subject { object.call(left, right) }

  let(:described_class) { Class.new(Relation::Operation::Sorted::Direction) }
  let(:header)          { Relation::Header.coerce([[:id, Integer]])         }
  let(:left)            { Tuple.new(header, [1])                            }
  let(:right)           { Tuple.new(header, [2])                            }
  let(:object)          { described_class.new(header[:id])                  }

  it 'sends the tuple value to self.class.call' do
    response = double('#call response')
    expect(described_class).to receive(:call).with(1, 2).and_return(response)
    should be(response)
  end
end
