#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.


# Load sidekiq web interface
require 'sidekiq/web' 
map('/sidekiq') { run Sidekiq::Web }

require File.expand_path("../config/boot.rb", __FILE__)

run Padrino.application