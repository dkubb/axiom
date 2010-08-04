require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Binary#call' do
  subject { connective.call(tuple) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ] ])     }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1) }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2) }
  let(:tuple)      { Tuple.new(header, [ 1 ])                       }
  let(:response)   { mock('#eval response')                         }
  let(:connective) { BinarySpecs::Object.new(left, right)           }

  before do
    BinarySpecs::Object.should_receive(:eval).with(true, false).and_return(response)
  end

  it { should equal(response) }
end
