require 'spec_helper'

describe 'Veritas::Algebra::Rename::Aliases#[]' do
  subject { object[attribute] }

  let(:klass)     { Algebra::Rename::Aliases    }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new(aliases)          }

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
