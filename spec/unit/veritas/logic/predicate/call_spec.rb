require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Logic::Predicate, '#call' do
  subject { object.call(tuple) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }
  let(:object) { described_class.new(header[:id], 1)        }

  it 'sends the left and right value to self.class.call' do
    response = mock('#call response')
    described_class.should_receive(:call).with(1, 1).and_return(response)
    should equal(response)
  end
end
