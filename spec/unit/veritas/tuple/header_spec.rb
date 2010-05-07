require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#header' do
  subject { tuple.header }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  it { should equal(header) }
end
