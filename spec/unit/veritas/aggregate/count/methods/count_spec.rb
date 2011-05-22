# encoding: utf-8

require 'spec_helper'

describe Aggregate::Count::Methods, '#count' do
  subject { object.count }

  let(:described_class) { Class.new { include Aggregate::Count::Methods } }
  let(:object)          { described_class.new.freeze                      }

  it { should be_kind_of(Aggregate::Count) }

  its(:operand) { should equal(object) }
end
