# Credstore
# - for working with encrypted data easily
#
# originated by Mike Heijmans
#
#   Apache License
#   Version 2.0, January 2004
#   http://www.apache.org/licenses/
#   Copyright 2013 Michael Heijmans

$:.unshift File.dirname(__FILE__)

require 'fileutils'
require 'openssl'
require 'base64'
require 'pstore'
require 'credstore/crypt'
require 'credstore/storage'

module Credstore
  def Credstore.version
    return "0.0.1"
  end
end