Credstore
=========
[![Gem Version](https://badge.fury.io/rb/credstore.png)](http://badge.fury.io/rb/credstore)

A Ruby gem that provides an object for working with encrypting and decrypting strings using RSA

	gem install credstore


Usage
---
	# Generate Keys using Crypt class
	require 'credstore'
	options = {:length=>2048, :keys_dir=>"./keys", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"}
	Credstore::Crypt.generate_keys(options)
	
	##
	# working with strings
	 
	# private key is optional.. if there is no private key supplied, you can encrypt but cannot decrypt.
	options = {:keys_dir=>"#{$LIB_BASE_DIR}/tmp/", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"}
	crypt = Credstore::Crypt.new(options)
	
	# Encrypt a string
	crypt.encrypt_string("Hello World")
	
	# Decrypt a string
	crypt.decrypt_string(crypt.encrypt_string("Hello World"))
	
	##
	# working with storage
	options = {:keys_dir=>"./keys", :database=>"credstore.db", :public_key=>"id_rsa.pub", :private_key=>"id_rsa"}
	storage = Credstore::Storage.new(options)
	
	# store encrypted string for key
	storage.write_key("key", "value")
	
	# decrypt and read value for key
	storage.read_key("key")
	
	# read and write keys using the dot operator shortcut
	storage.key="value"
	storage.key
	
	
Options Explanations
---
**Credstore::Crypt.generate_keys options:**
	
	* length => length of the key (default is 2048)
	* keys_dir => the directory that the keys will be written (default is ./)
	* public_key => the name of the public key (default is id_rsa.pub)
	* private_key => the name of the private key (default is id_rsa)
	
**Credstore::Crypt.new options:**

	* keys_dir => the directory that the key(s) are located (default is ./)
	* public_key => the public key (default is id_rsa.pub)
	* private_key => the private key (default is nil.. if there is no private key you will be able to encrypt but not decrypt strings)
	
**Credstore::Storage.new options:**

	* keys_dir => the directory that the key(s) are located (default is ./)
	* database => the path to the storage file for your credstore (default is ./credstore.db)
	* public_key => the public key (default is id_rsa.pub)
	* private_key => the private key (default is id_rsa)

	
