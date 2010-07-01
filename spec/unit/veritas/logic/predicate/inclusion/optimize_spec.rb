require 'spec_helper'

describe 'Veritas::Logic::Predicate::Inclusion#optimize' do
  subject { inclusion.optimize }

  let(:klass) { Logic::Predicate::Inclusion }
  let(:left)  { Attribute::Integer.new(:id) }

  context 'right is a Range' do
    context 'that is inclusive' do
      context 'and empty' do
        let(:right)     { 1..0                   }
        let(:inclusion) { klass.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }

        it_should_behave_like 'an optimize method'
      end

      context 'and not empty' do
        let(:right)     { 1..10                  }
        let(:inclusion) { klass.new(left, right) }

        it { should equal(inclusion) }

        it_should_behave_like 'an optimize method'
      end
    end

    context 'that is exclusive' do
      context 'and empty' do
        let(:right)     { 1...1                  }
        let(:inclusion) { klass.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }

        it_should_behave_like 'an optimize method'
      end

      context 'and not empty' do
        let(:right)     { 1...10                 }
        let(:inclusion) { klass.new(left, right) }

        it 'changes the Range to be inclusive' do
          should eql(left.include(1..9))
        end

        it_should_behave_like 'an optimize method'
      end
    end

    context 'using an attribute that is not comparable' do
      let(:left)      { Attribute::String.new(:string) }
      let(:inclusion) { klass.new(left, 'a'..'z')      }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is greater than the left range' do
      let(:right)     { 2**31..2**31           }
      let(:inclusion) { klass.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is less than the left range' do
      let(:right)     { -1..-1                 }
      let(:inclusion) { klass.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an Enumerable' do
    context 'that is empty' do
      let(:right)     { []                     }
      let(:inclusion) { klass.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is empty after filtering invalid entries' do
      let(:right)     { [ 'a' ]                }
      let(:inclusion) { klass.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that is not empty after filtering invalid entries' do
      let(:right)     { [ 'a', 1, 2 ]          }
      let(:inclusion) { klass.new(left, right) }

      it { should eql(left.include([ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has duplicate entries' do
      let(:right)     { [ 1, 2, 2 ]            }
      let(:inclusion) { klass.new(left, right) }

      it { should eql(left.include([ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has one entry' do
      let(:right)     { [ 1 ]                  }
      let(:inclusion) { klass.new(left, right) }

      it { should eql(left.eq(1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'that has unsorted entries' do
      let(:right)     { [ 2, 1 ]               }
      let(:inclusion) { klass.new(left, right) }

      it { should eql(left.include([ 1, 2 ])) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is a nil' do
    let(:right)     { nil                    }
    let(:inclusion) { klass.new(left, right) }

    it { should equal(Logic::Proposition::False.instance) }

    it_should_behave_like 'an optimize method'
  end
end
