require 'spec_helper'

describe Cucumber::Web::Paths do
  subject do
    mod = Module.new
    mod.extend Cucumber::Web::Paths
    mod
  end

  describe '.paths' do
    context 'when given a block' do
      it 'defines string to string paths' do
        subject.paths{ define('the homepage', '/') }
        subject.paths.should == [['the homepage', '/']]
      end

      it 'defines string to proc paths' do
        block = proc{ '/' }
        subject.paths{ define('the homepage', block) }
        subject.paths.should == [['the homepage', block]]
      end

      it 'defines string to block paths' do
        block = proc{ '/' }
        subject.paths{ define('the homepage', &block) }
        subject.paths.should == [['the homepage', block]]
      end

      it 'defines regular expression to string paths' do
        subject.paths{ define(/^the home ?page$/, '/') }
        subject.paths.should == [[/^the home ?page$/, '/']]
      end

      it 'defines regular expression to proc paths' do
        block = proc{ '/' }
        subject.paths{ define(/^the home ?page$/, block) }
        subject.paths.should == [[/^the home ?page$/, block]]
      end

      it 'defines regular expression to block paths' do
        block = proc{ '/' }
        subject.paths{ define(/^the home ?page$/, &block) }
        subject.paths.should == [[/^the home ?page$/, block]]
      end

      context 'and a block parameter' do
        it 'defines paths' do
          expect{ subject.paths{|p| p.define('the homepage', '/') } }.to change{ subject.paths.size }.from(0).to(1)
        end
      end
    end

    context 'when chained' do
      it 'defines paths' do
        expect{ subject.paths.define('the homepage', '/') }.to change{ subject.paths.size }.from(0).to(1)
      end
    end

    it 'adds paths to the top of the stack' do
      subject.paths.define(/^the home ?page$/, '/home')
      subject.paths.define('the homepage', '/')
      subject.paths.should == [['the homepage', '/'], [/^the home ?page$/, '/home']]
    end

    it 'aliases "define" as "path"' do
      expect{ subject.paths{ path('the homepage', '/') } }.to change{ subject.paths.size }.from(0).to(1)
    end
  end

  describe '.path' do
    it 'matches string patterns' do
      subject.stub(:paths => [['the homepage', '/']])
      subject.path('the homepage').should == '/'
    end

    it 'matches regular expression patterns' do
      subject.stub(:paths => [[/^the home ?page/, '/']])
      subject.path('the homepage').should == '/'
    end

    it 'returns nil for unmatched page names' do
      subject.stub(:paths => [['the homepage', '/']])
      subject.path('the home page').should == nil
    end

    it 'returns the matching path nearest the top of the stack' do
      subject.stub(:paths => [['the homepage', '/'], [/^the home ?page$/, '/home']])
      subject.path('the homepage').should == '/'
    end

    it 'returns an evaluated block value' do
      subject.stub(:paths => [['the homepage', proc{ '/' }]])
      subject.path('the homepage').should == '/'
    end
  end
end
