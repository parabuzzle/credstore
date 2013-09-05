# Credstore
# - for working with encrypted data easily
#
# originated by Mike Heijmans
#
#   Apache License
#   Version 2.0, January 2004
#   http://www.apache.org/licenses/
#   Copyright 2013 Michael Heijmans

require 'pstore'
require 'credstore/crypt'

module Credstore
  class Storage
    attr_accessor :store
    def initialize data_path, pstore="credstore.db", public_key="id_rsa.pub", private_key="id_rsa"
      @crypt = Credstore::Crypt.new(data_path, public_key, private_key)
      @store = PStore.new(File.join(data_path, pstore), true)
    end
    
    def write_key key, value
      @store.transaction do
        if value.nil?
          @store[key.to_sym] = nil
        else
          @store[key.to_sym] = @crypt.encrypt_string value
        end
      end
    end

    def read_key key
      @store.transaction do
        @crypt.decrypt_string @store[key.to_sym]
      end
    end

    def method_missing(id, *args)
      return self.write_key(id.id2name.gsub("=", ""), args.first) if id.id2name =~ /=.*/
      return self.read_key(id.id2name) if id.id2name =~ /.*/
    end

  end
end