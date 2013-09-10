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
require 'base64'

module Credstore
  class Crypt
    def initialize(opts={})
      opts[:keys_dir] ||= "./"
      opts[:public_key] ||= "id_rsa.pub"
      @data_path = opts[:keys_dir]
      @public_path = File.join(@data_path, opts[:public_key])
      @public = get_key opts[:public_key]
      if opts[:private_key]
        @private_path = File.join(@data_path, opts[:private_key])
        @private = get_key opts[:private_key]
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
    
    def self.generate_keys(opts={:length=>2048, :keys_dir=>"#{$LIB_BASE_DIR}/tmp/", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"})
      unless File.exists?(File.join(opts[:keys_dir], opts[:private_key])) || File.exists?(File.join(opts[:keys_dir], opts[:public_key]))
        keypair  = OpenSSL::PKey::RSA.generate(opts[:length])
        Dir.mkdir(opts[:keys_dir]) unless File.exist?(opts[:keys_dir])
        File.open(File.join(opts[:keys_dir], opts[:private_key]), 'w') { |f| f.write keypair.to_pem } unless File.exists? File.join(opts[:keys_dir], opts[:private_key])
        File.open(File.join(opts[:keys_dir], opts[:public_key]), 'w') { |f| f.write keypair.public_key.to_pem } unless File.exists? File.join(opts[:keys_dir], opts[:public_key])
      end
    end
    
    private
    def get_key filename
      OpenSSL::PKey::RSA.new File.read(File.join(@data_path, filename))
    end
  end
end