# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

 context 'Veritas::Relation::Operation::Binary::ClassMethods#new' do
   subject { object.new(left, right) }

   let(:original_left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
   let(:original_right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }
   let(:object)         { BinaryRelationOperationSpecs::Object                     }

   context 'with left and right ordered' do
     let(:left)  { original_left.order  { |r| r[:id]   } }
     let(:right) { original_right.order { |r| r[:name] } }

     it { should be_kind_of(object) }
   end

   context 'with left and right unordered' do
     let(:left)  { original_left  }
     let(:right) { original_right }

     it { should be_kind_of(object) }
   end

   context 'with left ordered, and right unordered' do
     let(:left)  { original_left.order { |r| r[:id] } }
     let(:right) { original_right                     }

     specify { expect { subject }.to raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end

   context 'with right ordered, and left unordered' do
     let(:left)  { original_left                         }
     let(:right) { original_right.order { |r| r[:name] } }

     specify { expect { subject }.to raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end
end
