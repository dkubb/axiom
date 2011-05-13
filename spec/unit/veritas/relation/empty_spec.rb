# encoding: utf-8

require 'spec_helper'

describe Relation, '#empty?' do
  subject { object.empty? }

  let(:header) { [ [ :id, Integer ] ]              }
  let(:object) { described_class.new(header, body) }

  before do
    object.should be_instance_of(described_class)
  end

  context 'with a body containing no entries' do
    let(:body) { [].each }  # use an Enumerator

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ].each }  # use an Enumerator

    it { should be(false) }
  end
end
