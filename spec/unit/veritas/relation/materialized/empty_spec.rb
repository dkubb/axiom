require 'spec_helper'

describe 'Veritas::Relation::Materialized#empty?' do
  subject { relation.empty? }

  let(:header)   { [ [ :id, Integer ] ]                     }
  let(:relation) { Relation::Materialized.new(header, body) }

  context 'with a body containing no entries' do
    let(:body) { [] }

    it { should be(true) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ] }

    it { should be(false) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end
  end
end
