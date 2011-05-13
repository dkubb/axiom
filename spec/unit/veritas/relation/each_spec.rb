# encoding: utf-8

require 'spec_helper'

describe Relation, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:body)   { [ [ 1 ], [ 2 ], [ 2 ] ].each               }  # use an Enumerator
  let(:object) { described_class.new(header, body)          }
  let(:yields) { []                                         }

  before do
    object.should be_instance_of(described_class)
  end

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ], [ 2 ] ])
  end
end

describe Relation do
  subject { object.new(header, body) }

  let(:header) { [ [ :id, Integer ] ] }
  let(:body)   { [ [ 1 ] ].each       }
  let(:object) { Relation             }

  before do
    subject.should be_instance_of(object)
  end

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
