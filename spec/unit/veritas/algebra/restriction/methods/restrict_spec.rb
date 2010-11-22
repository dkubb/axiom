require 'spec_helper'

describe 'Veritas::Algebra::Restriction::Methods#restrict' do
  let(:klass)  { Relation                                        }
  let(:object) { klass.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

  context 'with predicate arguments' do
    subject { object.restrict(predicate) }

    let(:predicate) { object[:id].eq(1) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 }
    end
  end

  context 'with a block' do
    subject { object.restrict(&block) }

    let(:block) { lambda { |relation| relation[:id].eq(1) } }

    it { should be_kind_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(block.call(object))
    end

    it 'behaves the same as Enumerable#select' do
      should == object.select { |tuple| tuple[:id] == 1 }
    end
  end
end
