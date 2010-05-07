require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#optimize' do
  subject { empty.optimize }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should equal(empty) }
end
