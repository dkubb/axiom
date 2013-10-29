# encoding: utf-8

require 'spec_helper'

describe Function::Proposition, '#rename' do
  subject { object.rename(aliases) }

  let(:object)          { described_class.instance         }
  let(:described_class) { Class.new(Function::Proposition) }
  let(:header)          { TABLE_DUM.header                 }
  let(:aliases)         { Algebra::Rename::Aliases.new({}) }

  it 'returns self' do
    should be(object)
  end
end
