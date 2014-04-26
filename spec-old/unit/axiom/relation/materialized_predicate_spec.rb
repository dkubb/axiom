# encoding: utf-8

require 'spec_helper'

describe Relation, '#materialized?' do
  subject { object.materialized? }

  let(:object) { described_class.new([[:id, Integer]], LazyEnumerable.new) }

  before do
    expect(object).to be_instance_of(described_class)
  end

  it { should be(false) }
end
