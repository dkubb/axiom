require 'spec_helper'

describe 'Veritas::Relation::Empty#optimize' do
  subject { object.optimize }

  let(:klass)  { Relation::Empty                 }
  let(:object) { klass.new([ [ :id, Integer ] ]) }

  it { should equal(object) }

  it_should_behave_like 'an optimize method'
end
