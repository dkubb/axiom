require 'spec_helper'

describe 'Veritas::Relation#header' do
  subject { object.header }

  let(:klass)  { Relation                                   }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [].each)                 }

  before do
    object.should be_instance_of(klass)
  end

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
