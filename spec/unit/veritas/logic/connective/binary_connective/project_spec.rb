require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#project' do
  let(:attribute)  { Attribute::Integer.new(:id)       }
  let(:other)      { Attribute::Integer.new(:other_id) }
  let(:attributes) { [ attribute ]                     }

  subject { connective.project(attributes) }

  describe 'left and right is removed' do
    let(:left)       { other.eq(1)                                    }
    let(:right)      { other.eq(2)                                    }
    let(:connective) { BinaryConnectiveSpecs::Object.new(left, right) }

    it { should be_nil }
  end

  describe 'left is removed' do
    let(:left)       { other.eq(1)                                    }
    let(:right)      { attribute.eq(2)                                }
    let(:connective) { BinaryConnectiveSpecs::Object.new(left, right) }

    it { should equal(right) }
  end

  describe 'right is removed' do
    let(:left)       { attribute.eq(1)                                }
    let(:right)      { other.eq(2)                                    }
    let(:connective) { BinaryConnectiveSpecs::Object.new(left, right) }

    it { should equal(left) }
  end

  describe 'neither left or right is removed' do
    let(:left)       { attribute.eq(1)                                }
    let(:right)      { attribute.eq(2)                                }
    let(:connective) { BinaryConnectiveSpecs::Object.new(left, right) }

    it 'delegates to super, but no #project in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end
end
