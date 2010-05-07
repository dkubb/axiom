require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Empty#empty?' do
  subject { empty.empty? }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should be(true) }
end
