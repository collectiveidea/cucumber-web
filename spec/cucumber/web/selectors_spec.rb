require 'spec_helper'

describe Cucumber::Web::Selectors do
  subject do
    mod = Module.new
    mod.extend Cucumber::Web::Selectors
    mod
  end

  describe '.selectors' do
    context 'when given a block' do
      it 'defines string to string selectors' do
        subject.selectors do
          define('the page', 'html > body')
        end
        subject.selectors.should == [['the page', 'html > body']]
      end

      it 'defines string to proc selectors' do
        block = proc{ 'html > body' }
        subject.selectors do
          define('the page', block)
        end
        subject.selectors.should == [['the page', block]]
      end

      it 'defines string to block selectors' do
        block = proc{ 'html > body' }
        subject.selectors do
          define('the page', &block)
        end
        subject.selectors.should == [['the page', block]]
      end

      it 'defines regular expression to string selectors' do
        subject.selectors do
          define(/^the page$/, 'html > body')
        end
        subject.selectors.should == [[/^the page$/, 'html > body']]
      end

      it 'defines regular expression to proc selectors' do
        block = proc{ 'html > body' }
        subject.selectors do
          define(/^the page$/, block)
        end
        subject.selectors.should == [[/^the page$/, block]]
      end

      it 'defines regular expression to block selectors' do
        block = proc{ 'html > body' }
        subject.selectors do
          define(/^the page$/, &block)
        end
        subject.selectors.should == [[/^the page$/, block]]
      end
    end
  end
end
