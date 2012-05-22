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
        subject.paths do
          define('the homepage', '/')
        end
        subject.paths.should == [['the homepage', '/']]
      end

      it 'defines string to proc paths' do
        block = proc{ '/' }
        subject.paths do
          define('the homepage', block)
        end
        subject.paths.should == [['the homepage', block]]
      end

      it 'defines string to block paths' do
        block = proc{ '/' }
        subject.paths do
          define('the homepage', &block)
        end
        subject.paths.should == [['the homepage', block]]
      end

      it 'defines regular expression to string paths' do
        subject.paths do
          define(/^the home ?page$/, '/')
        end
        subject.paths.should == [[/^the home ?page$/, '/']]
      end

      it 'defines regular expression to proc paths' do
        block = proc{ '/' }
        subject.paths do
          define(/^the home ?page$/, block)
        end
        subject.paths.should == [[/^the home ?page$/, block]]
      end

      it 'defines regular expression to block paths' do
        block = proc{ '/' }
        subject.paths do
          define(/^the home ?page$/, &block)
        end
        subject.paths.should == [[/^the home ?page$/, block]]
      end

      context 'and a block parameter' do
        it 'defines paths' do
          subject.paths do |paths|
            paths.define('the homepage', '/')
          end
          subject.paths.should == [['the homepage', '/']]
        end
      end
    end

    context 'when chained' do
      it 'defines paths' do
        subject.paths.define('the homepage', '/')
        subject.paths.should == [['the homepage', '/']]
      end
    end
  end
end
