require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction::Methods#restrict' do
  subject { relation.restrict(*args, &block) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  context 'with predicate arguments' do
    let(:predicate) { relation[:id].eq(1) }
    let(:args)      { [ predicate ]       }
    let(:block)     { nil                 }

    it { should be_kind_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end

    it 'behaves the same as Enumerable#select' do
      should == relation.select { |tuple| tuple[:id] == 1 }
    end
  end

  context 'with a block' do
    let(:args)  { []                                        }
    let(:block) { lambda { |relation| relation[:id].eq(1) } }

    it { should be_kind_of(Algebra::Restriction) }

    it 'sets the predicate' do
      subject.predicate.should eql(block.call(relation))
    end

    it 'behaves the same as Enumerable#select' do
      should == relation.select { |tuple| tuple[:id] == 1 }
    end
  end
end
