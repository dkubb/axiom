require 'spec_helper'

describe 'Veritas::Relation::Empty#empty?' do
  subject { empty.empty? }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it { should be(true) }
end
