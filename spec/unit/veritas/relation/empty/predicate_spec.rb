require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#predicate' do
  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  subject { empty.predicate }

  it { should equal(Logic::Proposition::False.instance) }
end
