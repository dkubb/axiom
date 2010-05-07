require File.expand_path('../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Predicate#call' do
  subject { predicate.call(tuple) }

  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)     { Tuple.new(header, [ 1 ])                   }
  let(:predicate) { PredicateSpecs::Object.new(header[:id], 1) }

  it 'sends the left and right value to self.class.eval' do
    response = mock('#eval response')
    PredicateSpecs::Object.should_receive(:eval).with(1, 1).and_return(response)
    should equal(response)
  end
end
