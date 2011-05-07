require 'spec_helper'

describe Aggregate::Mean, '.default' do
  subject { object.default }

  let(:object) { described_class }

  it_should_behave_like 'an idempotent method'

  it { should be_frozen }

  it { should == [ 0, nil ] }
end
