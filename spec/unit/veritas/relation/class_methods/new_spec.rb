# encoding: utf-8

require 'spec_helper'

describe Relation, '.new' do
  subject { object.new(header, body) }

  let(:header) { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:object) { described_class                            }
  let(:body)   { [ [ 1 ] ]                                  }

  context 'with an Enumerable responding to #size' do
    it { should be_instance_of(Relation::Materialized) }

    it { should == body.dup }
  end

  context 'with an Enumerable that returns nil for #size' do
    before do
      body.should_receive(:size).and_return(nil)
    end

    it { should be_instance_of(object) }

    it { should == body.dup }
  end

  context 'with an Enumerable that returns Float::INFINITY for #size' do
    before do
      body.should_receive(:size).and_return(Float::INFINITY)
    end

    it { should be_instance_of(object) }

    it { should == body.dup }
  end

  context 'with an Enumerable that does not respond to #size' do
    before do
      class << body
        undef_method(:size)
      end
    end

    it { should be_instance_of(object) }

    it { should == body.dup }
  end
end
