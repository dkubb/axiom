require 'spec_helper'

describe 'Veritas::Relation#empty?' do
  subject { relation.empty? }

  let(:header)   { [ [ :id, Integer ] ]       }
  let(:relation) { Relation.new(header, body) }

  context 'with a body containing no entries' do
    let(:body) { [].each }  # use an Enumerator

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ].each }  # use an Enumerator

    it { should be(false) }
  end
end
