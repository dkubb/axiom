require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Binary#call' do
  subject { object.call(tuple) }

  let(:klass)    { BinarySpecs::Object                            }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])     }
  let(:left)     { Logic::Predicate::Equality.new(header[:id], 1) }
  let(:right)    { Logic::Predicate::Equality.new(header[:id], 2) }
  let(:tuple)    { Tuple.new(header, [ 1 ])                       }
  let(:response) { mock('#call response')                         }
  let(:object)   { klass.new(left, right)                         }

  before do
    klass.should_receive(:call).with(true, false).and_return(response)
  end

  it { should equal(response) }
end
