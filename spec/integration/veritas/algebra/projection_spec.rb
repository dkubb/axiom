require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection' do
  describe 'remove attributes in predicate' do
    before do
      @left  = Relation.new([ [ :id, Integer ] ], (1..100).map { |n| [ n ] })
      @right = Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ], [ 'John Doe' ], [ 'Jane Doe' ] ])

      @relation = @left * @right

      @restriction = @relation.restrict { |r| r[:id].gte(1).and(r[:id].lte(10)).and(r[:name].eq('Dan Kubb')) }
    end

    subject { @restriction.project([ :name ]) }

    it 'should remove the predicates with the removed attributes' do
      subject.predicate.should == @relation[:name].eq('Dan Kubb')
    end

    it 'should return a relation with a single tuple' do
      subject.should == [ [ 'Dan Kubb' ] ]
    end

    it { should have_tuples_matching_predicate }
  end
end
