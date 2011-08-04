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
      expect { subject }.to_not change { yields.dup }
    end
  end

  context 'with an empty relation having tuples' do
    let(:tuples) { mock('Tuples')                      }
    let(:object) { described_class.new(header, tuples) }

    it_should_behave_like 'an #each method'

    it 'yields no tuples' do
      expect { subject }.to_not change { yields.dup }
    end
  end
end
