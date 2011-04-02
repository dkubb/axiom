require 'spec_helper'

describe Algebra::Rename::Aliases, '#empty?' do
  subject { object.empty? }

  let(:attribute) { Attribute::Integer.new(:id)  }
  let(:object)    { described_class.new(aliases) }

  context 'when aliases are empty' do
    let(:aliases) { {} }

    it { should be(true) }
  end

  context 'when aliases are not empty' do
    let(:aliases) { { attribute => attribute.rename(:other_id) } }

    it { should be(false) }
  end
end
