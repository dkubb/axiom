# encoding: utf-8

require 'spec_helper'

describe Relation, '#empty?' do
  subject { object.empty? }

  let(:header) { [[:id, Integer]]                  }
  let(:object) { described_class.new(header, body) }

  before do
    expect(object).to be_instance_of(described_class)
  end

  context 'with a body containing no entries' do
    let(:body) { LazyEnumerable.new }

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { LazyEnumerable.new([[1]]) }

    it { should be(false) }
  end
end
