require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Immutable, '#dup' do
  subject { object.dup }

  let(:described_class) { ImmutableSpecs::Object }
  let(:object)          { described_class.new    }

  it { should equal(object) }
end
