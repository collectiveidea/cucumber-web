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

    it 'adds selectors to the top of the stack' do
      subject.selectors.define(/^the page$/, 'body')
      subject.selectors.define('the page', 'html > body')
      subject.selectors.should == [['the page', 'html > body'], [/^the page$/, 'body']]
    end

    it 'aliases "define" as "selector"' do
      expect{ subject.selectors{ selector('the page', 'html > body') } }.to change{ subject.selectors.size }.from(0).to(1)
    end
  end

  describe '.selector' do
    it 'matches string patterns' do
      subject.stub(:selectors => [['the page', 'html > body']])
      subject.selector('the page').should == 'html > body'
    end

    it 'matches regular expression patterns' do
      subject.stub(:selectors => [[/^the page/, 'html > body']])
      subject.selector('the page').should == 'html > body'
    end

    it 'returns nil for unmatched page names' do
      subject.stub(:selectors => [['the page', 'html > body']])
      subject.selector('the entire page').should == nil
    end

    it 'returns the matching selector nearest the top of the stack' do
      subject.stub(:selectors => [['the page', 'html > body'], [/^the page$/, 'body']])
      subject.selector('the page').should == 'html > body'
    end

    it 'returns an evaluated block value' do
      subject.stub(:selectors => [['the page', proc{ 'html > body' }]])
      subject.selector('the page').should == 'html > body'
    end
  end
end
