require File.expand_path('../../../../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)

describe 'Veritas::Logic::Connective::BinaryConnective#hash' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ], [ :name, String ] ])
    @left   = Logic::Predicate::Equality.new(@header[:id], 1)
    @right  = Logic::Predicate::Equality.new(@header[:id], 2)

    @connective = BinaryConnectiveSpecs::Object.new(@left, @right)
  end

  subject { @connective.hash }

  it { should be_kind_of(Integer) }

  it { should == @left.hash ^ @right.hash }
end
