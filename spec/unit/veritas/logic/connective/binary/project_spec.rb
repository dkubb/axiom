require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::Binary#project' do
  subject { connective.project(attributes) }

  let(:attribute)  { Attribute::Integer.new(:id)          }
  let(:other)      { Attribute::Integer.new(:other_id)    }
  let(:attributes) { [ attribute ]                        }
  let(:connective) { BinarySpecs::Object.new(left, right) }

  context 'left and right is removed' do
    let(:left)  { other.eq(1) }
    let(:right) { other.eq(2) }

    it { should be_nil }
  end

  context 'left is removed' do
    let(:left)  { other.eq(1)     }
    let(:right) { attribute.eq(2) }

    it { should equal(right) }
  end

  context 'right is removed' do
    let(:left)  { attribute.eq(1) }
    let(:right) { other.eq(2)     }

    it { should equal(left) }
  end

  context 'neither left or right is removed' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it 'delegates to super, but no #project in superclass' do
      expect { subject }.to raise_error(NoMethodError)
    end
  end
end
