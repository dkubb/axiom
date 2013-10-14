# encoding: utf-8

require 'spec_helper'

describe Relation, '.new' do
  subject { object.new(header, body) }

  let(:header) { Relation::Header.coerce([[:id, Integer]]) }
  let(:object) { described_class                           }
  let(:body)   { [[1]]                                     }

  context 'with no body' do
    subject { object.new(header) }

    it { should be_instance_of(Relation::Materialized) }

    it { should be_empty }
  end

  context 'with a body responding to #size' do
    it { should be_instance_of(Relation::Materialized) }

    it { should == body.dup }

    it 'does not freeze the body' do
      expect(body).not_to be_frozen
      expect { subject }.to_not change(body, :frozen?)
    end
  end

  context 'with a body that returns nil for #size' do
    before do
      expect(body).to receive(:size).and_return(nil)
    end

    it { should be_instance_of(object) }

    it { should == body.dup }

    it 'does not freeze the body' do
      expect(body).not_to be_frozen
      expect { subject }.to_not change(body, :frozen?)
    end
  end

  context 'with a body that returns Float::INFINITY for #size' do
    before do
      expect(body).to receive(:size).and_return(Float::INFINITY)
    end

    it { should be_instance_of(object) }

    it { should == body.dup }

    it 'does not freeze the body' do
      expect(body).not_to be_frozen
      expect { subject }.to_not change(body, :frozen?)
    end
  end

  context 'with a body that does not respond to #size' do
    before do
      class << body
        undef_method(:size)
      end
    end

    it { should be_instance_of(object) }

    it { should == body.dup }

    it 'does not freeze the body' do
      expect(body).not_to be_frozen
      expect { subject }.to_not change(body, :frozen?)
    end
  end
end
