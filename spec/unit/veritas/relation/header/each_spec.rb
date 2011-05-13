# encoding: utf-8

require 'spec_helper'

describe Relation::Header, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:attribute) { Attribute::Integer.new(:id)        }
  let(:object)    { described_class.new([ attribute ]) }
  let(:yields)    { []                                 }

  it_should_behave_like 'an #each method'

  it 'yields each attribute' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ attribute ])
  end
end

describe Relation::Header do
  subject { object.new }

  let(:object) { Relation::Header }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
