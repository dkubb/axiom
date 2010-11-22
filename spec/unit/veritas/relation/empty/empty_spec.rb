require 'spec_helper'

describe 'Veritas::Relation::Empty#empty?' do
  subject { object.empty? }

  let(:klass)  { Relation::Empty                 }
  let(:object) { klass.new([ [ :id, Integer ] ]) }

  it { should be(true) }
end
