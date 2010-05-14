require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#eql?' do
  subject { connective.eql?(other) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:left)       { Logic::Predicate::Equality.new(header[:id], 1)                }
  let(:right)      { Logic::Predicate::Equality.new(header[:id], 2)                }
  let(:connective) { BinaryConnectiveSpecs::Object.new(left, right)                }

  context 'with the same connective' do
    let(:other) { connective }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(connective)
    end
  end

  context 'with an equivalent connective' do
    let(:other) { connective.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(connective)
    end
  end

  context 'with a different connective' do
    let(:other) { BinaryConnectiveSpecs::Object.new(header[:name], 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(connective)
    end
  end

  context 'with an equivalent connective of a different class' do
    let(:other) { Class.new(BinaryConnectiveSpecs::Object).new(header[:id], 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(connective)
    end
  end
end
