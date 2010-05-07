require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#wrap' do
  let(:relation)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:original_predicate) { relation[:id].eq(1)                           }
  let(:yields)             { []                                            }

  context 'without a predicate' do
    let(:predicate)   { original_predicate                            }
    let(:restriction) { Algebra::Restriction.new(relation, predicate) }

    subject { restriction.wrap { |relation| relation } }

    it { should_not be_equal(restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      expect {
        restriction.wrap { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ relation ])
    end

    it 'sets the relation with the block return values' do
      relation = mock('relation', :predicate => Logic::Proposition::True.instance)
      operation = restriction.wrap { relation }
      operation.relation.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end
  end

  context 'with a predicate' do
    let(:rename)      { relation.rename(:id => :other_id)           }
    let(:restriction) { Algebra::Restriction.new(rename, predicate) }
    let(:predicate)   { original_predicate.rename(:id => :other_id) }

    subject { restriction.wrap(predicate) { |relation| relation } }

    it { should_not be_equal(restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      expect {
        restriction.wrap { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ rename ])
    end

    it 'sets the relation with the block return values' do
      relation = mock('relation', :predicate => Logic::Proposition::True.instance)
      operation = restriction.wrap { relation }
      operation.relation.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end
  end
end
