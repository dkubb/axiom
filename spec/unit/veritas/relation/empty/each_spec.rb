require 'spec_helper'

describe 'Veritas::Relation::Empty#each' do
  subject { empty.each { |tuple| yields << tuple } }

  let(:empty)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:yields) { []                                        }

  it { should equal(empty) }

  it 'does not yield any tuples' do
    method(:subject).should_not change { yields.dup }
  end
end
