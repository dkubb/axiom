require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection::Set#initialize' do
  before do
    @relation = Relation.new(
      [ [ :id, Integer ], [ :name, String ] ],
      [
        [ 1, 'Dan Kubb' ],
        [ 2, 'Dan Kubb' ],
        [ 2, 'Alex Kubb'],
      ]
    )

    @header = @relation.header.project([ :id ])
  end

  subject { Veritas::Algebra::Projection::Set.new(@relation, @header) }

  it { should be_kind_of(Veritas::Algebra::Projection::Set) }

  it 'should set the internal state' do
    tuples = []
    subject.each { |tuple| tuples << tuple }
    tuples.should == [ [ 1 ], [ 2 ] ]
  end
end
