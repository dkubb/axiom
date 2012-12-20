# encoding: utf-8

require 'spec_helper'

describe Relation, '#eql?' do
  subject { object.eql?(other) }

  let(:header) { [ [ :id, Integer ] ]              }
  let(:body)   { LazyEnumerable.new([ [ 1 ] ])     }
  let(:object) { described_class.new(header, body) }

  before do
    object.should be_instance_of(described_class)
  end

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(header, body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different header' do
    let(:other_header) { [ [ :id, Numeric ] ]                          }
    let(:other_body)   { body                                          }
    let(:other)        { described_class.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having a different body' do
    let(:other_header) { header                                        }
    let(:other_body)   { LazyEnumerable.new([ [ 2 ] ])                 }
    let(:other)        { described_class.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end

  context 'with an object having an equivalent header in a different order' do
    let(:attribute1) { [ :id,   Integer ]                                                      }
    let(:attribute2) { [ :name, String  ]                                                      }
    let(:header1)    { [ attribute1, attribute2 ]                                              }
    let(:header2)    { [ attribute2, attribute1 ]                                              }
    let(:object)     { described_class.new(header1, LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ])) }
    let(:other)      { described_class.new(header2, LazyEnumerable.new([ [ 'Dan Kubb', 1 ] ])) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other.eql?(object))
    end
  end
end
