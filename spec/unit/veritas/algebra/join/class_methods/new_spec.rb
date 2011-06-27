# encoding: utf-8

require 'spec_helper'

describe Algebra::Join, '.new' do
  subject { object.new(left, right) }

  let(:header) { [ [ :id, Integer ] ]                   }
  let(:left)   { Relation.new(header, [ [ 1 ], [ 2 ] ]) }
  let(:object) { described_class                        }

  context 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    it { should be_instance_of(object) }
  end

  context 'with relations having equivalent headers' do
    let(:right) { left.dup }

    it { should be_instance_of(object) }
  end

  context 'with relations having different headers' do
    let(:right) { Relation.new([ [ :name, String ] ], [ [ 'Dan Kubb' ] ]) }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must have common attributes') }
  end
end
