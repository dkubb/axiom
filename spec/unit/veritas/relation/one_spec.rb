# encoding: utf-8

require 'spec_helper'

describe Relation, '#one' do
  subject { object.one }

  let(:object) { described_class.new(header, body)          }
  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }

  context 'with a relation having no tuples' do
    let(:body) { [].each }

    specify { expect { subject }.to raise_error(NoTuplesError, 'one tuple expected, but was an empty set') }

    specify { expect { subject }.to raise_error(SetSizeError) }
  end

  context 'with a relation having one tuple' do
    let(:body) { [ [ 1 ] ].each }

    it { should be_instance_of(Tuple) }

    it 'returns the expected tuple' do
      should == [ 1 ]
    end
  end

  context 'with a relation having many tuples' do
    let(:body) { [ [ 1 ], [ 2 ] ].each }

    specify { expect { subject }.to raise_error(ManyTuplesError, 'one tuple expected, but set contained 2 tuples') }
    specify { expect { subject }.to raise_error(SetSizeError) }
  end
end
