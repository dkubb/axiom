# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '.new' do
  subject { object.new(argument) }

  let(:object) { described_class              }
  let(:id)     { Attribute::Integer.new(:id)  }
  let(:name)   { Attribute::String.new(:name) }

  context 'with no arguments' do
    subject { object.new }

    it { should be_instance_of(object) }

    it { should be_empty }
  end

  context 'with an argument that responds to #to_ary and contains irreducible keys' do
    let(:argument) { [ Relation::Header.new([ id ]) ] }

    it { should be_instance_of(object) }

    it { should == argument }

    it 'does not freeze the argument' do
      argument.should_not be_frozen
      expect { subject }.to_not change(argument, :frozen?)
    end
  end

  context 'with an argument that responds to #to_ary and contains reducible keys' do
    let(:argument)        { [ reducible_key, irreducible_key ] }
    let(:reducible_key)   { Relation::Header.new([ id, name ]) }
    let(:irreducible_key) { Relation::Header.new([ id ])       }

    specify { expect { subject }.to raise_error(ReducibleKeyError, "reducible keys: #{[ reducible_key.to_set ].inspect}") }
  end

  context 'when the argument is not a Keys and does not respond to #to_ary' do
    let(:argument) { Object.new }

    specify { expect { subject }.to raise_error(NoMethodError) }
  end
end
