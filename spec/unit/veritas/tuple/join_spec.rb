require 'spec_helper'

describe Tuple, '#join' do
  subject { object.join(new_header, values) }

  let(:klass)      { Tuple                                      }
  let(:header)     { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:new_header) { header | [ [ :name, String ] ]             }
  let(:values)     { [ 'Dan Kubb' ]                             }
  let(:object)     { klass.new(header, [ 1 ])                   }

  it { should be_kind_of(klass) }

  its(:header) { should equal(new_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb' ] }
end
