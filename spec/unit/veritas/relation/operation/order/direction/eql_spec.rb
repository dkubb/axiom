require File.expand_path('../../../../../../../spec_helper', __FILE__)

[ :eql?, :== ].each do |method|
  describe "Veritas::Relation::Operation::Order::Direction##{method}" do
    let(:attribute) { Attribute::Integer.new(:id)                      }
    let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
    let(:direction) { klass.new(attribute)                             }

    subject { direction.send(method, other) }

    describe 'with the same direction' do
      let(:other) { direction }

      it { should be(true) }

      it 'is symmetric' do
        should == other.send(method, direction)
      end
    end

    describe 'with an equivalent direction' do
      let(:other) { direction.dup }

      it { should be(true) }

      it 'is symmetric' do
        should == other.send(method, direction)
      end
    end

    describe 'with a different direction' do
      let(:other_attribute) { Attribute::String.new(:name) }
      let(:other)           { klass.new(other_attribute)   }

      it { should be(false) }

      it 'is symmetric' do
        should == other.send(method, direction)
      end
    end

    describe 'with an equivalent direction of a different class' do
      let(:other) { Class.new(klass).new(attribute) }

      it { should be(false) }

      it 'is symmetric' do
        should == other.send(method, direction)
      end
    end
  end
end
