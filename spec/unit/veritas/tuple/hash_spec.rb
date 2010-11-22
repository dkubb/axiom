require 'spec_helper'

describe 'Veritas::Tuple#hash' do
  subject { object.hash }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Fixnum) }

  it { should == header.hash ^ [ 1 ].hash }
end
