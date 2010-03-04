require File.expand_path('../../../../spec_helper', __FILE__)

# use an infinite list to simulate handling a large Array.
# if any operation is inefficient, then the specs will never exit
class InfiniteList
  include Enumerable

  Infinity = 1.0/0.0

  def each
    (0..Infinity).each do |index|
      yield [ index ]
    end
    self
  end
end

describe 'Veritas::Algebra::Relation' do
  describe 'Efficient Enumerable operation' do
    before do
      @relation = Relation.new([ [ :id, Integer ] ], InfiniteList.new)
    end

    def sample(relation)
      relation.enum_for.take(5)
    end

    it '#project should be efficient' do
      relation = @relation.project([ :id ])
      sample(relation).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    it '#restrict should be efficient' do
      relation = @relation.restrict{ |r| r[:id].gt(5) }
      sample(relation).should == [ [ 6 ], [ 7 ], [ 8 ], [ 9 ], [ 10 ] ]
    end

    it '#product should be efficient' do
      relation = @relation.product(Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]))
      sample(relation).should == [ [ 0, 'Dan Kubb' ], [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ], [ 3, 'Dan Kubb' ], [ 4, 'Dan Kubb' ] ]
    end

    it '#difference should be efficient' do
      relation = @relation.difference(Relation.new(@relation.header, [ [ 1 ] ]))
      sample(relation).should == [ [ 0 ], [ 2 ], [ 3 ], [ 4 ], [ 5 ] ]
    end

    it '#union should be efficient' do
      relation = @relation.union(Relation.new(@relation.header, [ [ 1 ] ]))
      sample(relation).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end

    it '#rename should be efficient' do
      relation = @relation.rename(:id => :other_id)
      sample(relation).should == [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ]
    end
  end
end
