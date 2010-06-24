require 'spec_helper'

describe 'Veritas::Relation::Empty#each' do
  subject { empty.each { |tuple| yields << tuple } }

  let(:empty)  { Relation::Empty.new([ [ :id, Integer ] ]) }
  let(:yields) { []                                        }

  it { should equal(empty) }

  it 'does not yield any tuples' do
    expect { subject }.to_not change { yields.dup }
  end
end
