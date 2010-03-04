require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#predicate' do
  before do
    @empty = Relation::Empty.new([ [ :id, Integer ] ])
  end

  subject { @empty.predicate }

  it { should equal(Algebra::Restriction::False.instance) }
end
