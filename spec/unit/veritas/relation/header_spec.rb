# encoding: utf-8

require 'spec_helper'

describe Relation, '#header' do
  subject { object.header }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class.new(header, [].each)       }

  before do
    object.should be_instance_of(described_class)
  end

  it_should_behave_like 'an idempotent method'

  it { should equal(header) }
end
