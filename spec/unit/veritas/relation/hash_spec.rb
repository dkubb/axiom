require 'spec_helper'

describe 'Veritas::Relation#hash' do
  subject { object.hash }

  let(:klass)  { Relation                                   }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:body)   { [].each                                    }
  let(:object) { klass.new(header, body)                    }

  before do
    object.should be_instance_of(klass)
  end

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == klass.hash ^ header.hash ^ body.to_set.hash }
end
