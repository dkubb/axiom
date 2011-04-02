require 'spec_helper'

describe Relation::Empty, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object) { described_class.new([ [ :id, Integer ] ]) }
  let(:yields) { []                                        }

  it_should_behave_like 'a command method'

  it 'yields no tuples' do
    expect { subject }.to_not change { yields.dup }
  end
end
