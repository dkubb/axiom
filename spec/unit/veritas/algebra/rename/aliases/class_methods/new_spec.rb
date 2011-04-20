require 'spec_helper'

describe Algebra::Rename::Aliases, '.new' do
  subject { object.new(aliases) }

  let(:id)     { Attribute::Integer.new(:id)  }
  let(:uid)    { Attribute::Integer.new(:uid) }
  let(:object) { described_class              }

  context 'when aliases are unique' do
    let(:aliases)  { { id => id.rename(:other_id), uid => uid.rename(:other_uid) } }

    it { should be_kind_of(object) }
  end

  context 'when aliases are duplicated' do
    let(:aliases)  { { id => id.rename(:other), uid => uid.rename(:other) } }

    specify { expect { subject }.to raise_error(DuplicateAliasError, 'the aliases must be unique') }
  end
end
