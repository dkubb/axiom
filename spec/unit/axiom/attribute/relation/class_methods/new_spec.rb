# encoding: utf-8

require 'spec_helper'

describe Attribute::Relation, '.new' do
  subject { object.new(name, options) }

  let(:object) { described_class }
  let(:name)   { :ids            }

  context 'with a Header' do
    let(:options) { { header: header }                        }
    let(:header)  { Relation::Header.coerce([[:id, Integer]]) }

    it { should be_instance_of(described_class) }

    it 'sets the name' do
      expect(subject.name).to be(name)
    end

    it 'does not freeze the options' do
      expect(options).not_to be_frozen
      expect { subject }.to_not change(options, :frozen?)
    end

    it 'sets the expected header' do
      expect(subject.header).to be(header)
    end
  end

  context 'with attributes' do
    let(:options) { { header: header } }
    let(:header)  { [[:id, Integer]]   }

    it { should be_instance_of(described_class) }

    it 'sets the name' do
      expect(subject.name).to be(name)
    end

    it 'does not freeze the options' do
      expect(options).not_to be_frozen
      expect { subject }.to_not change(options, :frozen?)
    end

    it 'sets the expected header' do
      expect(subject.header).to eql(Relation::Header.coerce(header))
    end
  end

  context 'without a Header' do
    let(:options) { {} }

    specify { expect { subject }.to raise_error }
  end
end
