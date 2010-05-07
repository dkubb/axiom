require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Relation#==' do
  subject { relation == other }

  let(:header)   { [ [ :id, Integer ] ]         }
  let(:tuples)   { [ [ 1 ] ]                    }
  let(:relation) { Relation.new(header, tuples) }

  context 'with the same relation' do
    let(:other) { relation }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with an equivalent relation' do
    let(:other) { relation.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with an equivalent header and different tuples' do
    let(:other) { Relation.new(header, [ [ 2 ] ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with a different header' do
    let(:other) { Relation.new([ [ :name, String ] ], relation) }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with an equivalent object responding to #to_set' do
    let(:other) { Set[ [ 1 ] ] }

    it { should be(true) }

    it 'is symmetric' do
      pending 'Set#== should call to_set on other' do
        should == (other == relation)
      end
    end
  end

  context 'with a different object responding to #to_set' do
    let(:other) { Set[ [ 2 ] ] }

    it { should be(false) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with an equivalent header and equivalent tuples with attributes in a different order' do
    let(:attribute1) { [ :id,   Integer ]                               }
    let(:attribute2) { [ :name, String  ]                               }
    let(:header1)    { Relation::Header.new([ attribute1, attribute2 ]) }
    let(:header2)    { Relation::Header.new([ attribute2, attribute1 ]) }
    let(:relation)   { Relation.new(header1, [ [ 1, 'Dan Kubb' ] ])     }
    let(:other)      { Relation.new(header2, [ [ 'Dan Kubb', 1 ] ])     }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end

  context 'with an equivalent relation of a different class' do
    let(:other) { Class.new(Relation).new(header, tuples) }

    it { should be(true) }

    it 'is symmetric' do
      should == (other == relation)
    end
  end
end
