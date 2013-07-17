# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#keys' do
  subject { object.keys }

  let(:attributes) { [ [ :id, Integer ], [ :name, String ] ] }
  let(:keys_class) { Relation::Keys                          }

  context 'with explicit keys' do
    let(:object) { described_class.coerce(attributes, keys: keys) }
    let(:keys)   { [ [ :id ] ]                                    }

    it { should be_instance_of(keys_class) }

    it 'has a set of keys' do
      should == keys_class.new([ described_class.new([ object[:id] ]) ])
    end

    it { should be_frozen }
  end

  context 'with no explicit keys' do
    let(:object) { described_class.coerce(attributes) }

    it { should be_instance_of(keys_class) }

    it 'has an empty set of keys' do
      should be_empty
    end

    it { should be_frozen }
  end
end
