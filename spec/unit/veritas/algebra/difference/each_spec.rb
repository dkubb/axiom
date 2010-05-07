require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Difference#each' do
  subject { difference.each { |tuple| yields << tuple } }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }
  let(:yields) { []                              }

  context 'with relations having similar bodies' do
    let(:difference) { Algebra::Difference.new(left, left.dup) }

    it { should equal(difference) }

    it 'yields the difference' do
      method(:subject).should_not change { yields.dup }
    end
  end

  context 'with relations having different bodies' do
    let(:right)      { Relation.new(header, [ [ 2 ] ])      }
    let(:difference) { Algebra::Difference.new(left, right) }

    it { should equal(difference) }

    it 'yields the difference' do
      method(:subject).should change { yields.dup }.from([]).to([ [ 1 ] ])
    end
  end
end
