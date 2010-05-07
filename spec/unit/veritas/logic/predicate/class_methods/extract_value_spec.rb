require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate.extract_value' do
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  subject { Logic::Predicate.extract_value(operand, tuple) }

  context 'when the operand responds to #call' do
    let(:operand) { header[:id] }

    it { should == 1 }
  end

  context 'when the operand does not respond to #call' do
    let(:operand) { mock('Value') }

    it { should equal(operand) }
  end
end
