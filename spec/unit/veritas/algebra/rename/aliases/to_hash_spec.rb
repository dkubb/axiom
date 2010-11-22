require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#to_hash' do
  subject { object.to_hash }

  let(:klass)     { Algebra::Rename::Aliases    }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(aliases)          }

  context 'when aliases is frozen' do
    let(:aliases) { { attribute => attribute.rename(:other_id) }.freeze }

    it_should_behave_like 'an idempotent method'

    it { should equal(aliases) }
  end

  context 'when aliases is not frozen' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it_should_behave_like 'an idempotent method'

    it { should_not equal(aliases) }

    it { should be_kind_of(Hash) }

    it { should == aliases }

    it { should be_frozen }
  end
end
