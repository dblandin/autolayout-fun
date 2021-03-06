# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require 'bundler'

if ARGV.join(' ') =~ /spec/
  Bundler.require :default, :development, :spec
elsif ARGV.join(' ') =~ /archive/
  Bundler.require :default
else
  Bundler.require :default, :development
  require 'sugarcube'
  require 'sugarcube-repl'
end

require 'bubble-wrap/core'
require 'dotenv'
require './config/app_properties'

Dotenv.load

Motion::Project::App.setup do |app|
  properties = AppProperties.new

  app.detect_dependencies = false

  app.name              = properties.name
  app.identifier        = properties.identifier
  app.deployment_target = properties.deployment_target

  app.version                = properties.version
  app.short_version          = properties.version
  app.device_family          = properties.devices
  app.interface_orientations = properties.orientations

  app.icons                = properties.icons
  app.prerendered_icon     = properties.prerendered_icon
  app.provisioning_profile = properties.provisioning_profile

  app.release do
    app.codesign_certificate = properties.distribution_certificate
  end

  app.development do
    app.testflight do
      app.testflight.api_token  = ENV['TESTFLIGHT_API_TOKEN']
      app.testflight.team_token = ENV['TESTFLIGHT_TEAM_TOKEN']
      app.testflight.app_token  = ENV['TESTFLIGHT_APP_TOKEN']
    end
  end

  app.frameworks += properties.additional_frameworks
  app.libs       += properties.additional_libraries

  app_files = Dir.glob('./app/**/*.rb')
  app.files = (app.files - app_files) + properties.additional_files + app_files

  app.pods do
    pod 'CocoaLumberjack', '~> 1.6.2'
    pod 'SVProgressHUD',   '~> 0.9'
  end
end
