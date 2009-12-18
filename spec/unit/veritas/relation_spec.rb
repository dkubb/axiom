require File.expand_path('../../../spec_helper', __FILE__)

module Veritas
  describe Relation do
    describe '.new' do
      before do
        @header = [ [ :id, Integer ] ]
        @body   = [ [ 1 ] ]
      end

      subject { Relation.new(@header, @body) }

      it { should be_kind_of(Relation) }
    end
  end
end
