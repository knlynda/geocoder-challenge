RSpec.configure do |config|
  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :example do |example|
    if example.metadata[:type] == :feature || example.metadata[:js] || example.metadata[:truncation]
      Capybara.reset_sessions!
      sleep(0.5)
    end
    DatabaseRewinder.clean
  end
end
