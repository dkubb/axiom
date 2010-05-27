require 'spec_helper'

describe 'Veritas::Logic::Connective::Complement#call' do
  subject { complement.call(tuple) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:operand)    { header[:id].eq(1)                          }
  let(:complement) { Logic::Connective::Complement.new(operand) }

  context 'with a tuple that matches' do
    let(:tuple) { Tuple.new(header, [ 2 ]) }

    it { should be(true) }
  end

  context 'with a tuple that does not match' do
    let(:tuple) { Tuple.new(header, [ 1 ]) }

    it { should be(false) }
  end
end
