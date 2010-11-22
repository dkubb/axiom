require 'spec_helper'

describe 'Veritas::Relation#hash' do
  subject { object.hash }

  let(:klass)  { Relation                                 }
  let(:object) { klass.new([ [ :id, Integer ] ], [].each) }

  before do
    object.should be_instance_of(klass)
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == object.header.hash ^ object.to_set.hash }
end
