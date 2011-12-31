# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

if ENV['coverage']
  raise "simplecov only works on Ruby 1.9" unless RUBY_VERSION =~ /^1\.9/

  require 'simplecov'
  SimpleCov.start { add_filter "spec/" }
end

require 'watir-webdriver'
require 'locator_spec_helper'
require 'rubygems'
require 'rspec'

include Watir
include Watir::Exception

if ENV['ALWAYS_LOCATE'] == "false"
  Watir.always_locate = false
end

WEBDRIVER_SELECTORS = [:class, :class_name, :css, :id, :name, :tag_name, :xpath]

if ENV['TRAVIS']
  ENV['DISPLAY'] = ":99.0"
  ENV['PATH'] += ":#{File.expand_path "chrome-linux"}" if ENV['WATIR_WEBDRIVER_BROWSER'] == "chrome"
end

if Selenium::WebDriver::Platform.linux? && ENV['DISPLAY'].nil?
  raise "DISPLAY not set"
end
