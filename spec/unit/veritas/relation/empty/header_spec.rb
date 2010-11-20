require 'spec_helper'

describe 'Veritas::Relation::Empty#header' do
  subject { empty.header }

  let(:empty) { Relation::Empty.new([ [ :id, Integer ] ]) }

  it_should_behave_like 'an idempotent method'

  it { should == [ [ :id, Integer ] ] }
end
