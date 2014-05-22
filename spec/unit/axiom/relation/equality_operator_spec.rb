# encoding: utf-8

require 'spec_helper'

describe Relation, '#==' do
  subject { object == other }

  let(:header) { [[:id, Integer]]                  }
  let(:body)   { LazyEnumerable.new([[1]])         }
  let(:object) { described_class.new(header, body) }

  before do
    expect(object).to be_instance_of(described_class)
  end

  context 'with the same object' do
    let(:other) { object }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { Class.new(described_class).new(header, body) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having a different header' do
    let(:other_header) { [[:id, Numeric]]                              }
    let(:other_body)   { body                                          }
    let(:other)        { described_class.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having a different body' do
    let(:other_header) { header                                        }
    let(:other_body)   { LazyEnumerable.new([[2]])                     }
    let(:other)        { described_class.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an object having an equivalent header in a different order' do
    let(:attribute1) { [:id,   Integer]                                                    }
    let(:attribute2) { [:name, String]                                                     }
    let(:header1)    { [attribute1, attribute2]                                            }
    let(:header2)    { [attribute2, attribute1]                                            }
    let(:object)     { described_class.new(header1, LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:other)      { described_class.new(header2, LazyEnumerable.new([['Dan Kubb', 1]])) }

    it { should be(true) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object responding to #to_set' do
    let(:other) { Set[[1]] }

    it { should be(true) }

    it 'is symmetric', pending: 'Set#== should call to_set on other' do
      should eql(other == object)
    end
  end

  context 'with a different object responding to #to_set' do
    let(:other) { Set[[2]] }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with a different object not responding to #to_set' do
    let(:other) { Object.new }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with a different object having a superset of the headers' do
    let(:other_header) { [[:id, Integer], [:name, String]]             }
    let(:other_body)   { LazyEnumerable.new([[1, 'Dan Kubb']])         }
    let(:other)        { described_class.new(other_header, other_body) }

    it { should be(false) }

    it 'is symmetric' do
      should eql(other == object)
    end
  end
end
