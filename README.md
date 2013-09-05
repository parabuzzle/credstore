Credstore
=========

A Ruby gem that provides an object for working with encrypting and decrypting strings using RSA


Usage
---
	# Generate Keys using Crypt class
	require 'credstore'
	Credstore::Crypt.generate_keys(2048, "./keys", "id_rsa.pub", "id_rsa") # all arguments are optional
	
	##
	# working with strings
	 
	# private key is optional.. if there is no private key supplied, you can encrypt but cannot decrypt.
	crypt = Credstore::Crypt.new("./keys", public="id_rsa.pub", private="id_rsa")
	
	# Encrypt a string
	crypt.encrypt_string("Hello World")
	
	# Decrypt a string
	crypt.decrypt_string(crypt.encrypt_string("Hello World"))
	
	##
	# working with storage
	storage = Credstore::Storage(data_path, "credstore.db", "id_rsa.pub", "id_rsa")
	
	# store encrypted string for key
	storage.write_key("key", "value")
	
	# decrypt and read value for key
	storage.read_key("key")
	
	# read and write keys using the dot operator shortcut
	storage.key="value"
	storage.key
	
	
	
	
	