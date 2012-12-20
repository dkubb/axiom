# encoding: utf-8

require 'spec_helper'

describe Relation::Base, '#name' do
  subject { object.name }

  let(:header) { [ [ :id, Integer ] ]                    }
  let(:body)   { LazyEnumerable.new([ [ 1 ] ])           }
  let(:object) { described_class.new(name, header, body) }

  context 'when name is a frozen String' do
    let(:name) { 'users'.freeze }

    it_should_behave_like 'an idempotent method'

    it { should equal(name) }

    it { should be_frozen }
  end

  context 'when name is a String' do
    let(:name) { 'users' }

    it_should_behave_like 'an idempotent method'

    it { should_not equal(name) }

    it { should eql(name) }

    it { should be_frozen }
  end

  context 'when name responds to #to_s' do
    let(:name) { :users }

    it_should_behave_like 'an idempotent method'

    it { should_not equal(name) }

    it { should eql(name.to_s) }

    it { should be_frozen }
  end
end
