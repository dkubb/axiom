# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#send' do
  subject { object.send(method, args, &block) }

  let(:attribute) { Attribute::Integer.new(:id)              }
  let(:header)    { Relation::Header.new([attribute])        }
  let(:object)    { described_class.new(header, &EMPTY_PROC) }
  let(:method)    { :test                                    }
  let(:args)      { double('Arguments')                      }
  let(:block)     { EMPTY_PROC                               }

  before do
    def object.test(args, &block)
      [args, block]
    end
  end

  it 'delegates the arguments to the method' do
    expect(subject[0]).to be(args)
  end

  it 'delegates the block to the method' do
    expect(subject[1]).to be(block)
  end
end
