require File.expand_path('../../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order::DirectionSet' do
  subject { Relation::Operation::Order::DirectionSet.new(attributes) }

  let(:attributes) { [ Attribute::Integer.new(:id) ] }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end

describe 'Veritas::Relation::Operation::Order::DirectionSet#each' do
  subject { directions.each { |direction| yields << direction } }

  let(:attributes) { [ Attribute::Integer.new(:id), Attribute::String.new(:name) ] }
  let(:directions) { Relation::Operation::Order::DirectionSet.new(attributes)      }
  let(:yields)     { []                                                            }

  it { should equal(directions) }

  it 'yields each direction' do
    method(:subject).should change { yields.dup }.from([]).to(directions.to_ary)
  end
end
