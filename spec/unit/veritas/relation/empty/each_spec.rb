require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#each' do
  let(:empty)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:yields) { []                                        }

  subject { empty.each { |tuple| yields << tuple } }

  it { should equal(empty) }

  it 'does not yield any tuples' do
    method(:subject).should_not change { yields.dup }
  end
end
