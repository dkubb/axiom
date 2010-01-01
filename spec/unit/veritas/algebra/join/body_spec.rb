require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Join#body' do
  before do
    left  = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    right = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ])

    @relation = Algebra::Join.new(left, right)
  end

  subject { @relation.body }

  it { should be_kind_of(Relation::Body) }

  it 'should be the concatenation of the bodies on the common attributes' do
    subject.should == [ [ 2, 'Dan Kubb' ] ]

    # TODO: try removing this once #combine_bodies is removed/changed
    subject.to_set.should == Set[ [ 2, 'Dan Kubb' ] ]
  end
end
