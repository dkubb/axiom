# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#delete' do
  subject { object.delete(other) }

  let(:object) { described_class.new(relation, [ :id ]) }

  context 'when the other header matches the projection' do
    let(:relation) { Relation.new(header, [ [ 1 ], [ 2 ] ].each) }
    let(:other)    { Relation.new(header, [ [ 2 ] ].each)        }
    let(:header)   { [ [ :id, Integer ] ]                        }

    it { should be_instance_of(described_class) }

    its(:operand) { should be_kind_of(Relation) }

    its(:header) { should == [ [ :id, Integer ] ] }

    it 'deletes the tuples' do
      should == [ [ 1 ] ]
    end
  end

  context 'when the other header does not match the projection' do
    let(:relation) { Relation.new(header, [ [ 1, 'John Doe' ] ].each)                }
    let(:other)    { Relation.new(header, [ [ 1, 'John Doe' ] ].each)                }
    let(:header)   { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

    specify { expect { subject }.to raise_error(InvalidHeaderError, 'the headers must be equivalent') }
  end
end
