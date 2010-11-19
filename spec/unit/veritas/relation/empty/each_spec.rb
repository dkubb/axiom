require 'spec_helper'

describe 'Veritas::Relation::Empty#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)  { Relation::Empty                 }
  let(:object) { klass.new([ [ :id, Integer ] ]) }
  let(:yields) { []                              }

  it_should_behave_like 'a command method'

  it 'yields no tuples' do
    expect { subject }.to_not change { yields.dup }
  end
end
