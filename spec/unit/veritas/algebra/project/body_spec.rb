require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Project#body' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])

    @projection = Algebra::Project.new(@relation, [ :id ])
  end

  subject { @projection.body }

  it { should be_kind_of(Relation::Body) }

  it 'should only include projected attributes' do
    should == [ [ 1 ] ]
  end
end
