require 'spec_helper'

describe Logic::Connective::Disjunction, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)      }
  let(:object)    { described_class.new(left, right) }

  it_should_behave_like 'Logic::Connective::Binary#optimize'

  context 'left and right are predicates' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.lt(3) }

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are inverse predicates' do
    let(:left)  { Logic::Connective::Negation.new(attribute.gt(1)) }
    let(:right) { Logic::Connective::Negation.new(attribute.lt(3)) }

    it { should_not equal(object) }

    it 'reverses the operands' do
      should eql(Logic::Connective::Disjunction.new(attribute.lte(1), attribute.gte(3)))
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are the same' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.gt(1) }

    it { should equal(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are true propositions' do
    let(:left)  { Logic::Proposition::True.instance }
    let(:right) { Logic::Proposition::True.instance }

    it { should equal(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are false propositions' do
    let(:left)  { Logic::Proposition::False.instance }
    let(:right) { Logic::Proposition::False.instance }


    it { should equal(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'right is a true proposition' do
    let(:left)  { attribute.gt(1)                   }
    let(:right) { Logic::Proposition::True.instance }

    it { should equal(right) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a true proposition' do
    let(:left)  { Logic::Proposition::True.instance }
    let(:right) { attribute.lt(3)                   }

    it { should equal(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'right is a false proposition' do
    let(:left)  { attribute.gt(1)                    }
    let(:right) { Logic::Proposition::False.instance }

    it { should equal(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a false proposition' do
    let(:left)  { Logic::Proposition::False.instance }
    let(:right) { attribute.lt(3)                    }

    it { should equal(right) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are Equality predicates for the same attribute and different values' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(3) }

    it { should eql(attribute.include([ 1, 3 ])) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are Inequality predicates for the same attribute and different values' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.ne(3) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an Equality and right is an Inequality predicate for the same attribute and value' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an Inequality and right is an Equality predicate for the same attribute and value' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.eq(1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an Inclusion and right is an Exclusion predicate for the same attribute and value' do
    let(:left)  { attribute.include([ 1, 2 ]) }
    let(:right) { attribute.exclude([ 1, 2 ]) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an Exclusion and right is an Inclusion predicate for the same attribute and value' do
    let(:left)  { attribute.exclude([ 1, 2 ]) }
    let(:right) { attribute.include([ 1, 2 ]) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a GreaterThan and right is a LessThanOrEqualTo predicate for the same attribute and value' do
    let(:left)  { attribute.gt(1)  }
    let(:right) { attribute.lte(1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an LessThanOrEqualTo and right is an GreaterThan predicate for the same attribute and value' do
    let(:left)  { attribute.lte(1) }
    let(:right) { attribute.gt(1)  }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a GreaterThanOrEqualTo and right is a LessThan predicate for the same attribute and value' do
    let(:left)  { attribute.gte(1) }
    let(:right) { attribute.lt(1)  }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an LessThan and right is an GreaterThanOrEqualTo predicate for the same attribute and value' do
    let(:left)  { attribute.lt(1)  }
    let(:right) { attribute.gte(1) }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a Match and right is a NoMatch predicate for the same attribute and value' do
    let(:attribute)   { Attribute::String.new(:name) }
    let(:left)  { attribute.match(/Dan Kubb/)        }
    let(:right) { attribute.no_match(/Dan Kubb/)     }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an NoMatch and right is an Match predicate for the same attribute and value' do
    let(:attribute) { Attribute::String.new(:name)   }
    let(:left)      { attribute.no_match(/Dan Kubb/) }
    let(:right)     { attribute.match(/Dan Kubb/)    }

    it { should equal(Logic::Proposition::True.instance) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are predicates for the same attribute and the same values' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should eql(attribute.eq(1)) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are predicates for the same attribute, but left.right is an attribute' do
    let(:other) { Attribute::Integer.new(:other_id) }
    let(:left)  { attribute.eq(other)               }
    let(:right) { attribute.eq(1)                   }

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are predicates for the same attribute, but right.right is an attribute' do
    let(:other) { Attribute::Integer.new(:other_id) }
    let(:left)  { attribute.eq(1)                   }
    let(:right) { attribute.eq(other)               }

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end
end
