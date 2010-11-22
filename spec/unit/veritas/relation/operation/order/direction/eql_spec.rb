require 'spec_helper'

[ :eql?, :== ].each do |method|
  describe "Veritas::Relation::Operation::Order::Direction##{method}" do
    subject { object.send(method, other) }

    let(:klass)     { Class.new(Relation::Operation::Order::Direction) }
    let(:attribute) { Attribute::Integer.new(:id)                      }
    let(:object)    { klass.new(attribute)                             }

    context 'with the same direction' do
      let(:other) { object }

      it { should be(true) }

      it 'is symmetric' do
        should == other.send(method, object)
      end
    end

    context 'with an equivalent direction' do
      let(:other) { object.dup }

      it { should be(true) }

      it 'is symmetric' do
        should == other.send(method, object)
      end
    end

    context 'with a different direction' do
      let(:other_attribute) { Attribute::String.new(:name) }
      let(:other)           { klass.new(other_attribute)   }

      it { should be(false) }

      it 'is symmetric' do
        should == other.send(method, object)
      end
    end

    context 'with an equivalent direction of a different class' do
      let(:other) { Class.new(klass).new(attribute) }

      it { should be(false) }

      it 'is symmetric' do
        should == other.send(method, object)
      end
    end
  end
end
