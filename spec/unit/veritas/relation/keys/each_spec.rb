# encoding: utf-8

require 'spec_helper'

describe Relation::Keys, '#each' do
  subject { object.each { |key| yields << key } }

  let(:object) { described_class.coerce([ header ]) }
  let(:header) { [ [ :id ] ]                        }
  let(:yields) { []                                 }

  it_should_behave_like 'an #each method'

  it 'yields each attribute' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ header ])
  end
end

describe Relation::Keys do
  subject { object.new }

  let(:object) { described_class }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
