require File.expand_path('../../../../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/classes', __FILE__)

 describe 'Veritas::Relation::Operation::Binary::ClassMethods#new' do
   before do
     @left  = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
     @right = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
   end

   subject { BinaryRelationOperationSpecs::Object.new(@left, @right) }

   describe 'with left and right ordered' do
     before do
       @left  = @left.order  { |r| r[:id]   }
       @right = @right.order { |r| r[:name] }
     end

     it { should be_kind_of(Relation::Operation::Binary) }
   end

   describe 'with left and right unordered' do
     it { should be_kind_of(Relation::Operation::Binary) }
   end

   describe 'with left ordered, and right unordered' do
     before do
       @left = @left.order { |r| r[:id] }
     end

     it { method(:subject).should raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end

   describe 'with right ordered, and left unordered' do
     before do
       @right = @right.order { |r| r[:name] }
     end

     it { method(:subject).should raise_error(RelationMismatchError, 'both relations must be ordered or neither may be ordered') }
   end
end
