require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#predicate' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])

    @relation = @relation.restrict { |r| r[:name].eq('Dan Kubb') }
  end

  subject { @projection.predicate }

  describe 'containing a relation with a removed predicate' do
    before do
      @projection = @relation.project([ :id ])
    end

    it { should equal(Algebra::Restriction::True.instance) }
  end

  describe 'containing a relation without a removed predicate' do
    before do
      @projection = @relation.project([ :name ])
    end

    it { should equal(@relation.predicate) }
  end
end
