require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#empty?' do
  subject { object.empty? }

  let(:klass)     { Algebra::Rename::Aliases    }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(aliases)          }

  context 'when aliases are empty' do
    let(:aliases) { {} }

    it { should be(true) }
  end

  context 'when aliases are not empty' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it { should be(false) }
  end
end
