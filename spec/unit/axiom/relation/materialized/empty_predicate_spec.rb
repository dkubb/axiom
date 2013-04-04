# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#empty?' do
  subject { object.empty? }

  let(:header) { [ [ :id, Integer ] ]              }
  let(:object) { described_class.new(header, body) }

  context 'with a body containing no entries' do
    let(:body) { [] }

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ] }

    it { should be(false) }
  end
end
