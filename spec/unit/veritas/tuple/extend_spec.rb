require 'spec_helper'

describe Tuple, '#extend' do
  subject { object.extend(new_header, extensions) }

  let(:header)     { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:new_header) { header | [ [ :test, Integer ] ]                               }
  let(:extensions) { [ lambda { |tuple| 1 } ]                                      }
  let(:object)     { described_class.new(header, [ 1, 'Dan Kubb' ])                }

  it { should be_kind_of(described_class) }

  its(:header) { should equal(new_header) }

  its(:to_ary) { should == [ 1, 'Dan Kubb', 1 ] }
end
