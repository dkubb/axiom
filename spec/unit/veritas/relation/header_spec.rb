require 'spec_helper'

describe 'Veritas::Relation#header' do
  subject { relation.header }

  let(:header)   { [ [ :id, Integer ] ]            }
  let(:relation) { Relation.new(header, [ [ 1 ] ]) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Relation::Header) }

  it { should == header }
end
