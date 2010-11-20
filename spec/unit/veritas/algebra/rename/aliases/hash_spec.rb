require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#hash' do
  subject { object.hash }

  let(:klass)     { Algebra::Rename::Aliases                     }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:aliases)   { { attribute => attribute.rename(:other_id) } }
  let(:object)    { klass.new(aliases)                           }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Integer) }

  it { should == aliases.hash }
end
