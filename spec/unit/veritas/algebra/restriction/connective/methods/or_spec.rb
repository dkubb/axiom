require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Connective::Methods#or' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @connective = ConnectiveMethodSpecs::Object.new
  end

  subject { @connective.or(@predicate) }

  it { should be_kind_of(Algebra::Restriction::Disjunction) }
end

describe 'Veritas::Algebra::Restriction::Connective::Methods#|' do
  it 'is an alias to #or' do
    mod = Algebra::Restriction::Connective::Methods
    mod.instance_method(:|).should == mod.instance_method(:or)
  end
end
