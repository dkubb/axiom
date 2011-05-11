require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Binary, '#call' do
  subject { object.call(tuple) }

  let(:described_class) { BinarySpecs::Object                               }
  let(:header)          { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:left)            { Function::Predicate::Equality.new(header[:id], 1) }
  let(:right)           { Function::Predicate::Equality.new(header[:id], 2) }
  let(:tuple)           { Tuple.new(header, [ 1 ])                          }
  let(:response)        { mock('#call response')                            }
  let(:object)          { described_class.new(left, right)                  }

  before do
    described_class.should_receive(:call).with(true, false).and_return(response)
  end

  it { should equal(response) }
end
