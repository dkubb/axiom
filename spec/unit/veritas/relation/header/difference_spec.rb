require 'spec_helper'

[ :difference, :- ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    subject { object.send(method, other) }

    let(:klass)      { Relation::Header          }
    let(:attribute1) { [ :id,   Integer ]        }
    let(:attribute2) { [ :name, String  ]        }
    let(:object)     { klass.new([ attribute1 ]) }
    let(:other)      { klass.new([ attribute2 ]) }

    it { should be_kind_of(klass) }

    it { should == [ attribute1 ] }
  end
end
