require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Algebra::Restriction::Connective::Methods#and' do
  before do
    @header    = Relation::Header.new([ [ :id, Integer ] ])
    @predicate = Algebra::Restriction::Equality.new(@header[:id], 1)

    @connective = ConnectiveMethodSpecs::Object.new
  end

  subject { @connective.and(@predicate) }

  it { should be_kind_of(Algebra::Restriction::Conjunction) }
end

describe 'Veritas::Algebra::Restriction::Connective::Methods#&' do
  it 'is an alias to #and' do
    mod = Algebra::Restriction::Connective::Methods
    mod.instance_method(:&).should == mod.instance_method(:and)
  end
end
