require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Unary#call' do
  subject { object.call(tuple) }

  let(:klass)    { UnarySpecs::Object                         }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:operand)  { header[:id].eq(1)                          }
  let(:tuple)    { Tuple.new(header, [ 1 ])                   }
  let(:response) { mock('#call response')                     }
  let(:object)   { klass.new(operand)                         }

  before do
    klass.should_receive(:call).with(true).and_return(response)
  end

  it { should equal(response) }
end
