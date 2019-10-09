require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'cucumber'
require 'rest_client'
require 'rspec'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 2
Capybara.default_normalize_ws = true

rendered_config = ERB.new(File.read('config/config.json')).result binding
$config = JSON.parse(rendered_config)
$config['server'].insert(0, 'http://') unless $config['server'].start_with?('http')

Capybara.register_driver :selenium do |app|
  prefs = {
      download: {
          prompt_for_download: false,
          default_directory: $path
      }
  }
  options = Selenium::WebDriver::Chrome::Options.new(prefs: prefs)

  if Selenium::WebDriver::Platform.windows?
    Selenium::WebDriver::Chrome.driver_path = File.join(Dir.pwd, 'resources', 'chromedriver.exe').tr('/', '\\')
  else
    options.add_argument('--headless')
    options.add_argument('--window-size=1920,1080')
  end
  options.add_argument('--start-maximized')

  $driver = Capybara::Selenium::Driver.new(app, detach: false, browser: :chrome, options: options)
  $driver
end
