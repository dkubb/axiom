# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Unary, '#call' do
  subject { object.call(tuple) }

  let(:described_class) { UnarySpecs::Object                        }
  let(:header)          { Relation::Header.coerce([[:id, Integer]]) }
  let(:operand)         { header[:id].eq(1)                         }
  let(:tuple)           { Tuple.new(header, [1])                    }
  let(:response)        { double('#call response')                  }
  let(:object)          { described_class.new(operand)              }

  before do
    expect(described_class).to receive(:call).with(true).and_return(response)
  end

  it { should be(response) }
end
