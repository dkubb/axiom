# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Relation::Operation::Set::ClassMethods, '#new' do
  subject { object.new(left, right) }

  let(:header) { [ [ :id, Integer ] ]            }
  let(:left)   { Relation.new(header, [ [ 1 ] ]) }
  let(:object) { SetOperationSpecs::Object       }

  context 'with relations having equivalent headers' do
    let(:right) { Relation.new(header, [ [ 2 ] ]) }

    it { should be_kind_of(object) }
  end

  context 'with relations having headers with common attributes' do
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Dan Kubb' ] ]) }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end

  context 'with relations having different headers' do
    let(:right) { Relation.new([ [ :number, Integer ] ], [ [ 2 ] ]) }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end
end
