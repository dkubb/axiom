require 'spec_helper'

describe 'Veritas::Relation::Empty#optimize' do
  subject { empty.optimize }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should equal(empty) }
end
