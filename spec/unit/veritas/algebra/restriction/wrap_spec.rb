require 'spec_helper'

describe 'Veritas::Algebra::Restriction#wrap' do
  subject { restriction.wrap(*args) { |relation| relation } }

  let(:relation)           { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:original_predicate) { relation[:id].eq(1)                           }
  let(:predicate)          { original_predicate                            }
  let(:yields)             { []                                            }

  context 'without a predicate' do
    let(:restriction) { Algebra::Restriction.new(relation, predicate) }
    let(:args)        { []                                            }

    it { should_not equal(restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      expect {
        restriction.wrap { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ relation ])
    end

    it 'sets the relation with the block return values' do
      operation = restriction.wrap { relation }
      operation.operand.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end
  end

  context 'with a predicate' do
    let(:rename)      { relation.rename(:id => :other_id)           }
    let(:restriction) { Algebra::Restriction.new(rename, predicate) }
    let(:predicate)   { original_predicate.rename(:id => :other_id) }
    let(:args)        { [ predicate ]                               }

    it { should_not equal(restriction) }

    it { should be_kind_of(Algebra::Restriction) }

    it 'yields the relations' do
      expect {
        restriction.wrap(predicate) { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ rename ])
    end

    it 'sets the relation with the block return values' do
      operation = restriction.wrap(predicate) { relation }
      operation.operand.should equal(relation)
    end

    it 'sets the predicate' do
      subject.predicate.should equal(predicate)
    end
  end
end
