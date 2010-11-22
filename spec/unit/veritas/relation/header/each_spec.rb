require 'spec_helper'

describe 'Veritas::Relation::Header#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)     { Relation::Header            }
  let(:attribute) { Attribute::Integer.new(:id) }
  let(:object)    { klass.new([ attribute ])    }
  let(:yields)    { []                          }

  it_should_behave_like 'a command method'

  it 'yields each attribute' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ attribute ])
  end
end

describe 'Veritas::Relation::Header' do
  subject { object.new }

  let(:object) { Relation::Header }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
