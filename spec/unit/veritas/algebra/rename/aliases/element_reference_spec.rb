require 'spec_helper'

describe Algebra::Rename::Aliases, '#[]' do
  subject { object[attribute] }

  let(:attribute) { Attribute::Integer.new(:id)  }
  let(:object)    { described_class.new(aliases) }

  context 'when attribute is not renamed' do
    let(:aliases) { {} }

    it { should equal(attribute) }
  end

  context 'when attribute is renamed' do
    let(:renamed) { attribute.rename(:other_id) }
    let(:aliases) { { attribute => renamed }    }

    it { should equal(renamed) }
  end
end
