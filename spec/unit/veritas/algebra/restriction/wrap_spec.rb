require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#wrap' do
  before do
    @relation  = Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])
    @predicate = @relation[:id].eq(1)
  end

  describe 'without a predicate' do
    before do
      @restriction = Algebra::Restriction.new(@relation, @predicate)
    end

    subject { @restriction.wrap { |relation| relation } }

    it { should_not be_equal(@restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      @yield = []
      lambda {
        @restriction.wrap { |relation| @yield << relation; relation }
      }.should change { @yield.dup }.from([]).to([ @relation ])
    end

    it 'sets the relation with the block return values' do
      relation = mock('relation', :predicate => Algebra::Restriction::True.instance)
      operation = @restriction.wrap { relation }
      operation.relation.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(@predicate)
    end
  end

  describe 'with a predicate' do
    before do
      @rename = @relation.rename(:id => :other_id)

      @restriction = Algebra::Restriction.new(@rename, @predicate)
      @predicate   = @predicate.rename(:id => :other_id)
    end

    subject { @restriction.wrap(@predicate) { |relation| relation } }

    it { should_not be_equal(@restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      @yield = []
      lambda {
        @restriction.wrap { |relation| @yield << relation; relation }
      }.should change { @yield.dup }.from([]).to([ @rename ])
    end

    it 'sets the relation with the block return values' do
      relation = mock('relation', :predicate => Algebra::Restriction::True.instance)
      operation = @restriction.wrap { relation }
      operation.relation.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(@predicate)
    end
  end
end
