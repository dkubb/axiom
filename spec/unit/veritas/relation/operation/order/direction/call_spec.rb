require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Direction#call' do
  subject { direction.call(left, right) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:left)   { Tuple.new(header, [ 1 ])                   }
  let(:right)  { Tuple.new(header, [ 2 ])                   }
  let(:klass) do
    Class.new(Relation::Operation::Order::Direction) do
      def self.eval(*)
      end
    end
  end
  let(:direction) { klass.new(header[:id]) }

  it 'sends the tuple value to self.class.eval' do
    response = mock('#eval response')
    klass.should_receive(:eval).with(1, 2).and_return(response)
    should equal(response)
  end
end
