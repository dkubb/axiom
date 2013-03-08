# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#materialized?' do
  subject { object.materialized? }

  let(:object) { described_class.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  before do
    object.should be_instance_of(described_class)
  end

  it { should be(true) }
end
