require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Restriction#eql?' do
  subject { restriction.eql?(other) }

  let(:relation)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:restriction) { relation.restrict { true }                    }

  context 'with the same restriction' do
    let(:other) { restriction }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(restriction)
    end
  end

  context 'with an equivalent restriction' do
    let(:other) { restriction.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(restriction)
    end
  end

  context 'with a different restriction' do
    let(:other) { relation.restrict { false } }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(restriction)
    end
  end

  context 'with an equivalent restriction of a different class' do
    let(:other) { Class.new(Algebra::Restriction).new(relation, proc { true }) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(restriction)
    end
  end
end
