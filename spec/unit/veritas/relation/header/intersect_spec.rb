require 'spec_helper'

[ :intersect, :& ].each do |method|
  describe "Veritas::Relation::Header##{method}" do
    subject { object.send(method, other) }

    let(:klass)  { Relation::Header                  }
    let(:other)  { klass.new([ [ :name, String  ] ]) }
    let(:object) { klass.new([ [ :id,   Integer ] ]) }

    it { should be_kind_of(klass) }

    it { should be_empty }
  end
end
