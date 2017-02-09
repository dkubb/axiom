require 'spec_helper'

# tests Tuple type commutativity
describe "Axiom::Relation" do
  class TupleSubclass < Axiom::Tuple
    def initialize(header, values)
      super
    end
  end

  let(:header_ary)      { [[:index, Integer]] }
  let(:control_tuples)  { [ [ 0 ] ]                        }
  let(:header)          { Axiom::Relation::Header.coerce(header_ary) }
  let(:axiom_rel)       { Axiom::Relation.new(header, control_tuples) }

  it "should produce one row when natural joined with cloned tuples" do
    j = axiom_rel.join(Axiom::Relation.new(header, control_tuples.clone))
    j.count.should == 1
  end

  it "should produce one row when natural joined with Axiom::Tuple tuples" do
    j = axiom_rel.join(Axiom::Relation.new(header, [ Axiom::Tuple.new(header, [ 0 ]) ]))
    j.count.should == 1
  end

  it "should produce one row when natural joined with TupleSubclass tuples", known_failure: true do
    j = axiom_rel.join(Axiom::Relation.new(header, [ TupleSubclass.new(header, [ 0 ]) ]))
    j.count.should == 1
  end
end
