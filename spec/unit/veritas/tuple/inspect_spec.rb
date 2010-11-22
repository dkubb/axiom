require 'spec_helper'

describe 'Veritas::Tuple#inspect' do
  subject { object.inspect }

  let(:klass)  { Tuple                                      }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { klass.new(header, [ 1 ])                   }

  it { should be_kind_of(String) }

  it { should == '[1]' }
end
