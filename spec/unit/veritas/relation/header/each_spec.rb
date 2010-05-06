require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header' do
  subject { Relation::Header.new }

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end

describe 'Veritas::Relation::Header#each' do
  let(:attribute) { Attribute::Integer.new(:id)         }
  let(:header)    { Relation::Header.new([ attribute ]) }
  let(:yields)    { []                                  }

  subject { header.each { |tuple| yields << tuple } }

  it { should equal(header) }

  it 'yields each attribute' do
    method(:subject).should change { yields.dup }.from([]).to([ attribute ])
  end
end
