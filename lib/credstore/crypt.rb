# Credstore
# - for working with encrypted data easily
#
# originated by Mike Heijmans
#
#   Apache License
#   Version 2.0, January 2004
#   http://www.apache.org/licenses/
#   Copyright 2013 Michael Heijmans

require 'openssl'
require 'Base64'

module Credstore
  class Crypt
    def initialize data_path, public="id_rsa.pub", private=nil
      @data_path = data_path
      @public_path = File.join(data_path, public)
      @public = get_key public
      if private
        @private_path = File.join(data_path, private)
        @private = get_key private
      end
    end
    
    def encrypt_string message
      Base64::encode64(@public.public_encrypt(message)).rstrip
    end
    
    def decrypt_string message
      if message.nil?
        return nil
      end
      @private.private_decrypt Base64::decode64(message)
    end
    
    def self.generate_keys depth=2048, data_path="./", public="id_rsa.pub", private="id_rsa"
      unless File.exists?(File.join(data_path, private)) || File.exists?(File.join(data_path, public))
        keypair  = OpenSSL::PKey::RSA.generate(depth)
        Dir.mkdir(data_path) unless File.exist?(data_path)
        File.open(File.join(data_path, private), 'w') { |f| f.write keypair.to_pem } unless File.exists? File.join(data_path, private)
        File.open(File.join(data_path, public), 'w') { |f| f.write keypair.public_key.to_pem } unless File.exists? File.join(data_path, public)
      end
    end
    
    private
    def get_key filename
      OpenSSL::PKey::RSA.new File.read(File.join(@data_path, filename))
    end
  end
end