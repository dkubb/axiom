require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#optimize' do
  subject { connective.optimize }

  let(:attribute)      { Attribute::Integer.new(:id)                    }
  let(:original_left)  { attribute.gt(1)                                }
  let(:original_right) { attribute.lt(1)                                }
  let(:connective)     { BinaryConnectiveSpecs::Object.new(left, right) }

  context 'left and right are the same' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.gt(1) }

    it { should equal(left) }
  end

  context 'left and right are the same, after optimizing the left' do
    let(:left)  { original_left.and(Logic::Proposition::True.instance) }
    let(:right) { attribute.gt(1)                                      }

    it { should equal(original_left) }
  end

  context 'left and right are the same, after optimizing the right' do
    let(:left)  { attribute.gt(1)                                        }
    let(:right) { attribute.gt(1).and(Logic::Proposition::True.instance) }

    it { should equal(left) }
  end

  context 'left and right are different' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.lt(1) }

    it 'delegates to super, but no #optimize in superclass' do
      method(:subject).should raise_error(NoMethodError)
    end
  end

  context 'left and right are different, after optimizing the left' do
    let(:left)  { original_left.and(Logic::Proposition::True.instance) }
    let(:right) { attribute.lt(1)                                      }

    it { should_not equal(connective) }

    it { should be_instance_of(BinaryConnectiveSpecs::Object) }

    its(:left) { should equal(original_left) }

    its(:right) { should equal(right) }
  end

  context 'left and right are different, after optimizing the right' do
    let(:left)  { attribute.gt(1)                                       }
    let(:right) { original_right.and(Logic::Proposition::True.instance) }

    it { should_not equal(connective) }

    it { should be_instance_of(BinaryConnectiveSpecs::Object) }

    its(:left) { should equal(left) }

    its(:right) { should equal(original_right) }
  end

  context 'self and right are the same, and left and right.left are the same' do
    let(:left)  { attribute.eq(1)                                                     }
    let(:right) { BinaryConnectiveSpecs::Object.new(attribute.eq(1), attribute.ne(5)) }

    before do
      mod = Module.new do
        def optimize
          self
        end
      end

      right.extend(mod)
    end

    it { should equal(right) }
  end
end
