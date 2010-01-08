require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::Direction#call' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @left   = Tuple.new(@header, [ 1 ])
    @right  = Tuple.new(@header, [ 2 ])
    @klass  = Class.new(Relation::Operation::Order::Direction) do
      def self.eval(*)
      end
    end

    @direction = @klass.new(@header[:id])
  end

  subject { @direction.call(@left, @right) }

  it 'should send the tuple value to self.class.eval' do
    response = mock('#eval response')
    @klass.should_receive(:eval).with(1, 2).and_return(response)
    subject.should equal(response)
  end
end
