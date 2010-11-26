require 'spec_helper'

describe 'Veritas::Tuple#hash' do
  subject { object.hash }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:data)   { [ 1 ]                                      }
  let(:object) { klass.new(header, data)                    }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ header.hash ^ data.hash }
end
