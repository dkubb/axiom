require File.expand_path('../../../../spec_helper', __FILE__)

module Veritas
  module Algebra
    describe Union do
      before do
        header = [ [ :id, Integer ] ]

        @left  = Relation.new(header, [ [ 1 ] ])
        @right = Relation.new(header, [ [ 2 ] ])
      end

      it { Union.new(@left, @right).should be_kind_of(Relation) }
    end
  end

  describe '.new' do
    subject { Algebra::Union.new(@left, @right) }

    it { should be_kind_of(Algebra::Union) }
  end
end
