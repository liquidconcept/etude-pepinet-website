$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rubygems'
require 'bundler/setup'
require 'bundler/capistrano'

load 'deploy'
load 'deploy/assets'

Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy'
