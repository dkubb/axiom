require 'spec_helper'

describe 'Veritas::Relation::Materialized#optimize' do
  subject { relation.optimize }

  let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], body) }

  context 'with an empty Array' do
    let(:body) { [] }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == relation
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an nonempty Array' do
    let(:body) { [ [ 1 ] ] }

    it { should equal(relation) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
