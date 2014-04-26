# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Aliasable, '#inheritable_alias' do
  subject { object.inheritable_alias(aliases) }

  let(:object)    { Class.new(AliasableSpecs::Object) }
  let(:aliases)   { { other: :test }                  }
  let(:aliasable) { object.new                        }
  let(:arg)       { double('arg')                     }

  it_should_behave_like 'a command method'

  it 'creates a method alias' do
    expect { subject }
      .to change { aliasable.respond_to?(:other) }.from(false).to(true)
  end

  it 'forwards arguments to aliased method' do
    subject
    expect(aliasable).to receive(:test).with(arg)
    aliasable.other(arg)
  end

  it 'forwards the block to aliased method' do
    subject
    yieldparam = double('yieldparam')
    expect(aliasable).to receive(:test).and_yield(yieldparam)
    expect { |block| aliasable.other(arg, &block) }
      .to yield_with_args(yieldparam)
  end

  it 'returns value from aliased method' do
    subject
    retval = double('retval')
    expect(aliasable).to receive(:test).and_return(retval)
    expect(aliasable.other(arg)).to be(retval)
  end
end
