require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#predicate' do
  subject { empty.predicate }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should equal(Logic::Proposition::False.instance) }
end
