require 'spec_helper'

describe Algebra::Extension, '.new' do
  subject { object.new(operand, extensions) }

  let(:operand) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ], [ 2, 'Dan Kubb' ] ]) }
  let(:object)  { described_class                                                                                 }

  context 'with a unique attribute name provided' do
    let(:extensions) { { :unique => lambda { |tuple| 1 } } }

    it { should be_kind_of(object) }
  end

  context 'with a duplicate attribute name provided' do
    let(:extensions) { { :id => proc {}, :name => proc {} } }

    specify { expect { subject }.to raise_error(DuplicateAttributeError, 'extensions with duplicate header names: id, name') }
  end
end
