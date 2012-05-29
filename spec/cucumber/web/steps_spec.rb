require 'spec_helper'
require 'cucumber/rb_support/rb_dsl'

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

      context 'and a block parameter' do
        it 'defines steps' do
          expect{ subject.steps{|s| s.define('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
        end
      end
    end

    context 'when chained' do
      it 'defines steps' do
        expect{ subject.steps.define('I debug'){} }.to change{ subject.steps.size }.from(0).to(1)
      end
    end

    it 'adds paths to the top of the stack' do
      pry, debugger = proc{ binding.pry }, proc{ debugger }
      subject.steps.define(/^I (debug|pry)$/, &pry)
      subject.steps.define('I debug', &debugger)
      subject.steps.should == [['I debug', debugger], [/^I (debug|pry)$/, pry]]
    end

    it 'aliases "define" as "step"' do
      expect{ subject.steps{ step('I debug'){} } }.to change{ subject.steps.size }.from(0).to(1)
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

  describe '.register_steps' do
    it 'registers defined steps in Cucumber' do
      pry, debugger = proc{ binding.pry }, proc{ debugger }
      subject.steps.define(/^I (debug|pry)$/, pry)
      subject.steps.define('I debug', debugger)

      Cucumber::RbSupport::RbDsl.should_receive(:register_rb_step_definition).once.with(/^I (debug|pry)$/, pry)
      Cucumber::RbSupport::RbDsl.should_receive(:register_rb_step_definition).once.with('I debug', debugger)

      subject.register_steps
    end
  end
end
