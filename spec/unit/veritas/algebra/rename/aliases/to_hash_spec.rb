require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#to_hash' do
  subject { object.to_hash }

  let(:klass)     { Algebra::Rename::Aliases                     }
  let(:attribute) { Attribute::Integer.new(:id)                  }
  let(:object)    { klass.new(aliases)                           }

  context 'when aliases is frozen' do
    let(:aliases) { { attribute => attribute.rename(:other_id) }.freeze }

    it { should equal(aliases) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when aliases is not frozen' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it { should_not equal(aliases) }

    it { should eql(aliases) }

    it_should_behave_like 'an idempotent method'
  end
end
