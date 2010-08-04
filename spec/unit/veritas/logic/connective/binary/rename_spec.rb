require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Binary#rename' do
  subject { connective.rename(aliases) }

  let(:attribute)  { Attribute::Integer.new(:id)          }
  let(:other)      { Attribute::Integer.new(:other_id)    }
  let(:aliases)    { { attribute.name => other.name }     }
  let(:connective) { BinarySpecs::Object.new(left, right) }

  context 'left and right are renamed' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it { should eql(BinarySpecs::Object.new(other.eq(1), other.eq(2))) }
  end

  context 'left is renamed' do
    let(:left)  { attribute.eq(1) }
    let(:right) { other.eq(2)     }

    it { should eql(BinarySpecs::Object.new(other.eq(1), other.eq(2))) }
  end

  context 'right is renamed' do
    let(:left)  { other.eq(1)     }
    let(:right) { attribute.eq(2) }

    it { should eql(BinarySpecs::Object.new(other.eq(1), other.eq(2))) }
  end

  context 'right and right are not renamed' do
    let(:left)  { other.eq(1) }
    let(:right) { other.eq(2) }

    it { should equal(connective) }
  end
end
