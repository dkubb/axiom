require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#empty?' do
  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  subject { empty.empty? }

  it { should be(true) }
end
