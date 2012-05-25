require 'spec_helper'

describe Cucumber::Web::Steps do
  subject do
    mod = Module.new
    mod.extend Cucumber::Web::Steps
    mod
  end

  describe '.steps' do
    context 'when given a block' do
      it 'defines string to block steps' do
        block = proc{ binding.pry }
        subject.steps{ define('I debug', &block) }
        subject.steps.should == [['I debug', block]]
      end

      it 'defines regular expression to block steps' do
        block = proc{ binding.pry }
        subject.steps{ define(/^I (debug|pry)$/, &block) }
        subject.steps.should == [[/^I (debug|pry)$/, block]]
      end

      it 'defines string to proc steps' do
        block = proc{ binding.pry }
        subject.steps{ define('I debug', block) }
        subject.steps.should == [['I debug', block]]
      end

      it 'defines regular expression to proc steps' do
        block = proc{ binding.pry }
        subject.steps{ define(/^I (debug|pry)$/, block) }
        subject.steps.should == [[/^I (debug|pry)$/, block]]
      end

      it 'aliases "define" as "Given"' do
        expect{ subject.steps{ Given('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
      end

      it 'aliases "define" as "When"' do
        expect{ subject.steps{ When('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
      end

      it 'aliases "define" as "Then"' do
        expect{ subject.steps{ Then('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
      end

      it 'aliases "define" as "And"' do
        expect{ subject.steps{ And('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
      end

      it 'aliases "define" as "But"' do
        expect{ subject.steps{ But('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
      end
    end
  end
end
