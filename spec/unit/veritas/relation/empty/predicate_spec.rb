require 'spec_helper'

describe 'Veritas::Relation::Empty#predicate' do
  subject { empty.predicate }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should equal(Logic::Proposition::False.instance) }
end
