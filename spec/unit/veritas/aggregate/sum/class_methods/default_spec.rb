require 'spec_helper'

describe Aggregate::Sum, '.default' do
  subject { object.default }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should == 0 }
end
