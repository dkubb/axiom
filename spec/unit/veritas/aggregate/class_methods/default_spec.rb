require 'spec_helper'

describe Aggregate, '.default' do
  subject { object.default }

  let(:object) { described_class }

  specify { expect { subject }.to raise_error(NameError, "uninitialized constant #{Aggregate}::DEFAULT") }
end
