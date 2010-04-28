require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Logic::Predicate::Inclusion#optimize' do
  before do
    @left = Attribute::Integer.new(:id)
  end

  subject { @inclusion.optimize }

  describe 'left is an attribute' do
    describe 'right is a Range' do
      describe 'that is inclusive' do
        describe 'and empty' do
          before do
            @right = 1..0

            @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
          end

          it { should equal(Logic::Proposition::False.instance) }
        end

        describe 'and not empty' do
          before do
            @right = 1..10

            @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
          end

          it { should equal(@inclusion) }
        end
      end

      describe 'that is exclusive' do
        describe 'and empty' do
          before do
            @right = 1...1

            @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
          end

          it { should equal(Logic::Proposition::False.instance) }
        end

        describe 'and not empty' do
          before do
            @right = 1...10

            @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
          end

          it 'changes the Range to be inclusive' do
            should eql(@left.in(1..9))
          end
        end
      end

      describe 'using an attribute that is not comparable' do
        before do
          @left = Attribute::String.new(:string)

          @inclusion = Logic::Predicate::Inclusion.new(@left, 'a'..'z')
        end

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is greater than the left range' do
        before do
          @right = 2**31..2**31

          @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
        end

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is less than the left range' do
        before do
          @right = -1..-1

          @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
        end

        it { should equal(Logic::Proposition::False.instance) }
      end
    end

    describe 'right is an Enumerable' do
      describe 'that is empty' do
        before do
          @right = []

          @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
        end

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is empty after filtering invalid values' do
        before do
          @right = [ 'a' ]

          @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
        end

        it { should equal(Logic::Proposition::False.instance) }
      end

      describe 'that is not empty after filtering invalid values' do
        before do
          @right = [ 'a', 1 ]

          @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
        end

        it { should eql(@left.in([ 1 ])) }
      end
    end

    describe 'right is a nil' do
      before do
        @right = nil

        @inclusion = Logic::Predicate::Inclusion.new(@left, @right)
      end

      it { should equal(Logic::Proposition::False.instance) }
    end
  end
end
