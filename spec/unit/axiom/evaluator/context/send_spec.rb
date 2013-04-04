# encoding: utf-8

require 'spec_helper'

describe Evaluator::Context, '#send' do
  subject { object.send(method, args, &block) }

  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:object)    { described_class.new(header) {}      }
  let(:method)    { :test                               }
  let(:args)      { mock('Arguments')                   }
  let(:block)     { proc {}                             }

  before do
    def object.test(args, &block)
      return args, block
    end
  end

  it 'delegates the arguments to the method' do
    subject[0].should equal(args)
  end

  it 'delegates the block to the method' do
    subject[1].should equal(block)
  end
end
