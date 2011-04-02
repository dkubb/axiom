require 'spec_helper'

describe Algebra::Rename::Aliases, '#hash' do
  subject { object.hash }

  let(:klass)     { Algebra::Rename::Aliases                     }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { klass.new(aliases)                           }

  it_should_behave_like 'a hash method'

  it { should == klass.hash ^ aliases.hash }
end
