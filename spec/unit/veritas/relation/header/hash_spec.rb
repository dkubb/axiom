require 'spec_helper'

describe 'Veritas::Relation::Header#hash' do
  subject { object.hash }

  let(:klass)  { Relation::Header                }
  let(:object) { klass.new([ [ :id, Integer ] ]) }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == object.to_ary.hash }
end
