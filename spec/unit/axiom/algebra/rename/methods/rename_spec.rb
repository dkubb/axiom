# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename::Methods, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { Relation                                                          }
  let(:attribute)       { Attribute::Integer.new(:id)                                       }
  let(:aliases)         { { id: :other_id }                                                 }
  let(:object)          { described_class.new([ attribute ], LazyEnumerable.new([ [ 1 ] ])) }

  it { should be_instance_of(Algebra::Rename) }
end
