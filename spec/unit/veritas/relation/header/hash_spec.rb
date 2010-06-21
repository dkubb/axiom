require 'spec_helper'

describe 'Veritas::Relation::Header#hash' do
  subject { header.hash }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  it { should be_kind_of(Integer) }

  it { should == header.to_ary.hash }

  it_should_behave_like 'an idempotent method'
end
