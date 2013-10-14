# encoding: utf-8

require 'spec_helper'

describe Relation, '#directions' do
  subject { object.directions }

  let(:body)   { LazyEnumerable.new                          }
  let(:object) { described_class.new([[:id, Integer]], body) }

  before do
    expect(object).to be_instance_of(described_class)
  end

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Operation::Order::DirectionSet) }

  it { should be_empty }
end
