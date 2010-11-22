require 'spec_helper'

describe 'Veritas::Attribute#call' do
  subject { object.call(tuple) }

  let(:klass)  { Attribute::Integer                  }
  let(:object) { klass.new(:id)                      }
  let(:header) { Relation::Header.new([ object ])    }
  let(:tuple)  { Tuple.new(header, [ 1 ])            }

  it { should == 1 }
end
