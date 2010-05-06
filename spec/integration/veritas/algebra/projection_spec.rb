require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection' do
  describe 'remove attributes in predicate' do
    let(:left)        { Relation.new([ [ :id, Integer ] ], (1..100).map { |n| [ n ] })                           }
    let(:right)       { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ], [ 'John Doe' ], [ 'Jane Doe' ] ])  }
    let(:relation)    { left * right                                                                             }
    let(:restriction) { relation.restrict { |r| r[:id].gte(1).and(r[:id].lte(10)).and(r[:name].eq('Dan Kubb')) } }

    subject { restriction.project([ :name ]) }

    it 'removes the predicates with the removed attributes' do
      subject.predicate.should eql(relation[:name].eq('Dan Kubb'))
    end

    it 'returns a relation with a single tuple' do
      subject.should == [ [ 'Dan Kubb' ] ]
    end

    it { should have_tuples_matching_predicate }
  end
end
