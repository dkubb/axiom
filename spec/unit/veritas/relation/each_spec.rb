require 'spec_helper'

describe 'Veritas::Relation#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)  { Relation                                   }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:tuples) { [ [ 1 ], [ 2 ], [ 2 ] ]                    }
  let(:object) { klass.new(header, tuples)                  }
  let(:yields) { []                                         }

  it_should_behave_like 'a command method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ], [ 2 ] ])
  end
end

describe 'Veritas::Relation' do
  subject { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
