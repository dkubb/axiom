require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#wrap' do
  before do
    @relation = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @aliases  = { :id => :other_id }

    @rename = Algebra::Rename.new(@relation, @aliases)
  end

  subject { @rename.wrap { |relation| relation } }

  it { should_not be_equal(@rename) }

  it { should be_kind_of(Algebra::Rename) }

  it 'yields the relations' do
    @yield = []
    lambda {
      @rename.wrap { |relation| @yield << relation; relation }
    }.should change { @yield.dup }.from([]).to([ @relation ])
  end

  it 'sets the relation with the block return values' do
    relation = mock('relation')
    operation = @rename.wrap { relation }
    operation.relation.should equal(relation)
  end

  it 'sets the aliases' do
    subject.aliases.should == @aliases
  end
end
