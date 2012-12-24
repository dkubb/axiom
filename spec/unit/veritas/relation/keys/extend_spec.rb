# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#extend' do
  subject { object.extend(attributes) }

  let(:object)    { described_class.new([ header ]) }
  let(:header)    { Relation::Header.new            }
  let(:attribute) { Attribute::Integer.new(:id)     }

  context 'with attributes that do not change the keys' do
    let(:attributes) { [] }

    it { should equal(object) }
  end

  context 'with attributes that change the keys' do
    let(:attributes) { [ attribute ] }

    it { should be_instance_of(described_class) }

    it { should == described_class.new([ Relation::Header.coerce([ attribute ]) ]) }
  end
end
