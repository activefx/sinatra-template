# Use truncation before suite and for js features, see:
# http://quickleft.com/blog/five-capybara-hacks-to-make-your-testing-experience-less-painful
# http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
# http://platformonrails.wordpress.com/2013/02/27/a-path-to-fast-and-honest-tests-rspec-and-database-cleaner/
# https://semaphoreci.com/community/tutorials/working-effectively-with-data-factories-using-factorygirl
#
RSpec.configure do |config|
  config.add_setting(:seed_tables)
  config.seed_tables = []

  config.before(:suite) do
    # Do truncation once per suite to vacuum for Postgres
    DatabaseCleaner.clean_with :truncation, except: config.seed_tables
    # Normally do transactions-based cleanup
    DatabaseCleaner[:active_record].strategy = :transaction
    # Disable to avoid monogoid error below
    # DatabaseCleaner[:mongoid].strategy = :truncation
    begin
      DatabaseCleaner.start
      # cache_http_requests cassette_name: 'factories' do
        factories_to_lint = FactoryGirl.factories.reject do |factory|
          !(factory.name =~ /^valid_/)
        end

        FactoryGirl.lint factories_to_lint
      # end
    ensure
      DatabaseCleaner.clean
    end
  end

  config.around(:each) do |spec|
    if spec.metadata[:js] || spec.metadata[:test_commit]
      # JS => run with PhantomJS that doesn't share connections => can't use transactions
      # deletion is often faster than truncation on Postgres - doesn't vacuum
      # no need to 'start', clean_with is sufficient for deletion
      # Devise Emails: devise-async sends confirmation on commit only! => can't use transactions
      spec.run
      # Raises "The 'deletion' strategy does not exist for the mongoid ORM!"
      # when a mongoid strategy is defined
      DatabaseCleaner.clean_with :deletion, except: config.seed_tables
    else
      # No JS/Devise => run with Rack::Test => transactions are ok
      DatabaseCleaner.cleaning do
        spec.run
      end
    end
  end

end

