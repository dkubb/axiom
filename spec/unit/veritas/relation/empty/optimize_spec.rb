require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#optimize' do
  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  subject { empty.optimize }

  it { should equal(empty) }
end
