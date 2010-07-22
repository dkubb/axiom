require 'spec_helper'

describe 'Veritas::Relation::Materialized#empty?' do
  subject { relation.empty? }

  let(:header) { [ [ :id, Integer ] ] }

  context 'with a body containing no entries' do
    let(:relation) { Relation::Materialized.new(header, []) }

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:relation) { Relation::Materialized.new(header, [ [ 1 ] ]) }

    it { should be(false) }
  end
end
