require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion#optimize' do
  let(:left) { Attribute::Integer.new(:id) }

  subject { inclusion.optimize }

  describe 'left is an attribute' do
    describe 'right is a Range' do
      describe 'that is inclusive' do
        describe 'and empty' do
          let(:right)     { 1..0                                         }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(Logic::Proposition::False.instance) }
        end

        describe 'and not empty' do
          let(:right)     { 1..10                                        }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(inclusion) }
        end
      end

      describe 'that is exclusive' do
        describe 'and empty' do
          let(:right)     { 1...1                                        }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it { should equal(Logic::Proposition::False.instance) }
        end

        describe 'and not empty' do
          let(:right)     { 1...10                                       }
          let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

          it 'changes the Range to be inclusive' do
            should eql(left.in(1..9))
          end
        end
      end

      describe 'using an attribute that is not comparable' do
        let(:left)      { Attribute::String.new(:string)                  }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, 'a'..'z') }

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is greater than the left range' do
        let(:right)     { 2**31..2**31                                 }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is less than the left range' do
        let(:right)     { -1..-1                                       }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end
    end

    describe 'right is an Enumerable' do
      describe 'that is empty' do
        let(:right)     { []                                           }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is empty after filtering invalid values' do
        let(:right)     { [ 'a' ]                                      }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is not empty after filtering invalid values' do
        let(:right)     { [ 'a', 1 ]                                   }
        let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

        it { should eql(left.in([ 1 ])) }
      end
    end

    describe 'right is a nil' do
      let(:right)     { nil                                          }
      let(:inclusion) { Logic::Predicate::Inclusion.new(left, right) }

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
