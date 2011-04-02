require 'spec_helper'

describe Algebra::Rename::Methods, '#rename' do
  subject { object.rename(aliases) }

  let(:described_class) { Relation                                           }
  let(:attribute)       { Attribute::Integer.new(:id)                        }
  let(:aliases)         { { :id => :other_id }                               }
  let(:object)          { described_class.new([ attribute ], [ [ 1 ] ].each) }

  it { should be_kind_of(Algebra::Rename) }
end
