require 'spec_helper'

describe 'Veritas::Algebra::Intersection#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)  { Algebra::Intersection           }
  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }
  let(:yields) { []                              }
  let(:object) { klass.new(left, right)          }

  context 'with relations having similar bodies' do
    let(:right) { left.dup }

    it_should_behave_like 'a command method'

    it 'yields each tuple' do
      expect { subject }.to change { yields.dup }.from([]).to([ [ 1 ] ])
    end
  end

  context 'with relations having different bodies' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    it_should_behave_like 'a command method'

    it 'yields each tuple' do
      expect { subject }.to_not change { yields.dup }
    end
  end
end
