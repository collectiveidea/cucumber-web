require 'spec_helper'

describe Cucumber::Web::Paths do
  describe '.paths' do
    context 'when given a block' do
      it 'defines string to string paths' do
        Cucumber::Web.paths do
          define('the homepage', '/')
        end
        Cucumber::Web.paths.should == [['the homepage', '/']]
      end

      it 'defines string to proc paths' do
        block = proc{ '/' }
        Cucumber::Web.paths do
          define('the homepage', block)
        end
        Cucumber::Web.paths.should == [['the homepage', block]]
      end

      it 'defines string to block paths' do
        block = proc{ '/' }
        Cucumber::Web.paths do
          define('the homepage', &block)
        end
        Cucumber::Web.paths.should == [['the homepage', block]]
      end

      it 'defines regular expression to string paths' do
        Cucumber::Web.paths do
          define(/^the home ?page$/, '/')
        end
        Cucumber::Web.paths.should == [[/^the home ?page$/, '/']]
      end

      it 'defines regular expression to proc paths' do
        block = proc{ '/' }
        Cucumber::Web.paths do
          define(/^the home ?page$/, block)
        end
        Cucumber::Web.paths.should == [[/^the home ?page$/, block]]
      end

      it 'defines regular expression to block paths' do
        block = proc{ '/' }
        Cucumber::Web.paths do
          define(/^the home ?page$/, &block)
        end
        Cucumber::Web.paths.should == [[/^the home ?page$/, block]]
      end
    end
  end
end
