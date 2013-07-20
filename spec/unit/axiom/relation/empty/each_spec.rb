# encoding: utf-8

require 'spec_helper'

describe Relation::Empty, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:header) { [ [ :id, Integer ] ] }
  let(:yields) { []                   }

  context 'with an empty relation having no tuples' do
    let(:object) { described_class.new(header) }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      subject
      yields.should be_empty
    end
  end

  context 'with an empty relation having tuples' do
    let(:tuples) { double('Tuples')                    }
    let(:object) { described_class.new(header, tuples) }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      subject
      yields.should be_empty
    end
  end
end
