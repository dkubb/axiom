require 'spec_helper'

describe Relation::Operation::Order::Direction, '#call' do
  subject { object.call(left, right) }

  let(:klass)  { Class.new(Relation::Operation::Order::Direction) }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ])       }
  let(:left)   { Tuple.new(header, [ 1 ])                         }
  let(:right)  { Tuple.new(header, [ 2 ])                         }
  let(:object) { klass.new(header[:id])                           }

  it 'sends the tuple value to self.class.call' do
    response = mock('#call response')
    klass.should_receive(:call).with(1, 2).and_return(response)
    should equal(response)
  end
end
