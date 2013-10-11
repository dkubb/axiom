# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#context' do
  subject { object.context(&block) }

  let(:object)    { described_class.coerce([attribute]) }
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:block)     { ->(context) { }                     }
  let(:context)   { double('context')                   }

  before do
    Evaluator::Context.should_receive(:new).with(object)
      .and_yield(context)
      .and_return(context)
  end

  it 'is an evaluator context' do
    should be(context)
  end

  it 'yields an evaluator context' do
    expect { |block| object.context(&block) }
      .to yield_with_args(context)
  end
end
