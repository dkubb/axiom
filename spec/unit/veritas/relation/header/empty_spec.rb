require 'spec_helper'

describe 'Veritas::Relation::Header#empty?' do
  subject { object.empty? }

  let(:klass) { Relation::Header }

  context 'with attributes' do
    let(:object) { klass.new([ [ :id, Integer ] ]) }

    it { should be(false) }
  end

  context 'without attributes' do
    let(:object) { klass.new }

    it { should be(true) }
  end
end
