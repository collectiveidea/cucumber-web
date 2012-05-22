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
        subject.selectors{ define('the page', 'html > body') }
        subject.selectors.should == [['the page', 'html > body']]
      end

      it 'defines string to proc selectors' do
        block = proc{ 'html > body' }
        subject.selectors{ define('the page', block) }
        subject.selectors.should == [['the page', block]]
      end

      it 'defines string to block selectors' do
        block = proc{ 'html > body' }
        subject.selectors{ define('the page', &block) }
        subject.selectors.should == [['the page', block]]
      end

      it 'defines regular expression to string selectors' do
        subject.selectors{ define(/^the page$/, 'html > body') }
        subject.selectors.should == [[/^the page$/, 'html > body']]
      end

      it 'defines regular expression to proc selectors' do
        block = proc{ 'html > body' }
        subject.selectors{ define(/^the page$/, block) }
        subject.selectors.should == [[/^the page$/, block]]
      end

      it 'defines regular expression to block selectors' do
        block = proc{ 'html > body' }
        subject.selectors{ define(/^the page$/, &block) }
        subject.selectors.should == [[/^the page$/, block]]
      end

      context 'and a block parameter' do
        it 'defines selectors' do
          subject.selectors{|s| s.define('the page', 'html > body') }
          subject.selectors.should == [['the page', 'html > body']]
        end
      end
    end

    context 'when chained' do
      it 'defines selectors' do
        subject.selectors.define('the page', 'html > body')
        subject.selectors.should == [['the page', 'html > body']]
      end
    end
  end
end
