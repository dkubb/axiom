require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#predicate' do
  subject { restriction.predicate }

  describe 'when the relation has a True proposition' do
    let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
    let(:predicate)   { relation[:id].eq(1)                           }
    let(:restriction) { Algebra::Restriction.new(relation, predicate) }

    before do
      relation.predicate.should equal(Logic::Proposition::True.instance)
    end

    it { should equal(predicate) }
  end

  describe 'when the relation has a False proposition' do
    let(:empty)       { Relation::Empty.new([ [ :id, Integer ] ])  }
    let(:predicate)   { empty[:id].eq(1)                           }
    let(:restriction) { Algebra::Restriction.new(empty, predicate) }

    before do
      empty.predicate.should equal(Logic::Proposition::False.instance)
    end

    it { should equal(Logic::Proposition::False.instance) }
  end

  describe 'when the relation has a predicate' do
    let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]).restrict { |r| r[:id].eq(1) } }
    let(:predicate)   { relation[:id].ne(0)                                                         }
    let(:restriction) { Algebra::Restriction.new(relation, predicate)                               }

    it { should be_kind_of(Logic::Connective::Conjunction) }

    it { should eql(relation.predicate & predicate) }
  end
end
