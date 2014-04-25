# encoding: utf-8

require 'spec_helper'

describe Attribute, '#type' do
  subject { object.type }

  let(:described_class) { Class.new(Attribute) }
  let(:object)          { described_class      }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{object}.type is not implemented") }
end
