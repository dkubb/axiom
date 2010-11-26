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

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ header.hash ^ body.to_set.hash }
end
