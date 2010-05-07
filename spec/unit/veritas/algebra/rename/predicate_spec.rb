require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Rename#predicate' do
  let(:header)  { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:aliases) { { :id => :other_id }                       }

  subject { rename.predicate }

  context 'containing an empty relation' do
    let(:empty)  { Relation::Empty.new(header)         }
    let(:rename) { Algebra::Rename.new(empty, aliases) }

    it { should equal(Logic::Proposition::False.instance) }
  end

  context 'containing a relation' do
    let(:relation) { Relation.new(header, [ [ 1 ] ])        }
    let(:rename)   { Algebra::Rename.new(relation, aliases) }

    it { should equal(Logic::Proposition::True.instance) }
  end

  context 'containing a relation with a predicate' do
    let(:relation)    { Relation.new(header, [ [ 1 ], [ 2 ] ])    }
    let(:restriction) { relation.restrict { |r| r[:id].eq(1) }    }
    let(:rename)      { Algebra::Rename.new(restriction, aliases) }

    it { should eql(Attribute::Integer.new(:other_id).eq(1)) }
  end
end
