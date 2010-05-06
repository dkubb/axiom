require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

 describe 'Veritas::Relation::Operation::Binary::ClassMethods#new' do
   let(:original_left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
   let(:original_right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }

   subject { BinaryRelationOperationSpecs::Object.new(left, right) }

   describe 'with left and right ordered' do
     let(:left)  { original_left.order  { |r| r[:id]   } }
     let(:right) { original_right.order { |r| r[:name] } }

     it { should be_kind_of(Relation::Operation::Binary) }
   end

   describe 'with left and right unordered' do
     let(:left)  { original_left  }
     let(:right) { original_right }

     it { should be_kind_of(Relation::Operation::Binary) }
   end

   describe 'with left ordered, and right unordered' do
     let(:left)  { original_left.order { |r| r[:id] } }
     let(:right) { original_right                     }

     it { method(:subject).should raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end

   describe 'with right ordered, and left unordered' do
     let(:left)  { original_left                         }
     let(:right) { original_right.order { |r| r[:name] } }

     it { method(:subject).should raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end
end
