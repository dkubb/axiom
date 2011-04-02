require 'spec_helper'

describe Relation, '#empty?' do
  subject { object.empty? }

  let(:klass)  { Relation                }
  let(:header) { [ [ :id, Integer ] ]    }
  let(:object) { klass.new(header, body) }

  before do
    object.should be_instance_of(klass)
  end

  context 'with a body containing no entries' do
    let(:body) { [].each }  # use an Enumerator

    it { should be(true) }
  end

  context 'with a body containing an entry' do
    let(:body) { [ [ 1 ] ].each }  # use an Enumerator

    it { should be(false) }
  end
end
