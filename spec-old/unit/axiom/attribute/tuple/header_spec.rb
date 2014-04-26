# encoding: utf-8

require 'spec_helper'

describe Attribute::Tuple, '#header' do
  subject { object.header }

  let(:object)  { described_class.new(:ids, options)        }
  let(:options) { { header: header }                        }
  let(:header)  { Relation::Header.coerce([[:id, Integer]]) }

  it { should be(header) }
end
