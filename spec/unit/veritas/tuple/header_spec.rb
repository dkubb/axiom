require 'spec_helper'

describe 'Veritas::Tuple#header' do
  subject { tuple.header }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuple)  { Tuple.new(header, [ 1 ])                   }

  it { should equal(header) }

  it_should_behave_like 'an idempotent method'
end
