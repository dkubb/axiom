require 'spec_helper'

describe 'Veritas::Algebra::Extension::Methods#extend' do
  subject { object.extend(*args, &block) }

  let(:klass)      { Relation                                   }
  let(:extensions) { { :test => lambda { |tuple| 1 } }          }
  let(:object)     { klass.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

  context 'with extensions' do
    let(:args)  { [ extensions ] }
    let(:block) { nil            }

    it { should be_kind_of(Algebra::Extension) }

    its(:operand) { should equal(object) }
  end

  context 'with a block' do
    let(:args)  { []                        }
    let(:block) { lambda { |r| extensions } }

    it { should be_kind_of(Algebra::Extension) }

    its(:operand) { should equal(object) }
  end
end
