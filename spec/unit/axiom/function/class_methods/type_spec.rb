# encoding: utf-8

require 'spec_helper'
require File.expand_path('../../fixtures/classes', __FILE__)

describe Function, '.type' do
  subject { object.type }

  let(:object) { FunctionSpecs::Object }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{object}.type is not implemented") }
end
