require 'spec_helper'

describe Relation::Empty, '#optimize' do
  subject { object.optimize }

  let(:object) { described_class.new([ [ :id, Integer ] ]) }

  it { should equal(object) }

  it_should_behave_like 'an optimize method'
end
