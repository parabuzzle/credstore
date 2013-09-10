Gem::Specification.new do |s|
  s.name        = 'credstore'
  s.version     = '1.0.1'
  s.date        = '2013-09-04'
  s.summary     = "A gem that makes it easy to encrypt and decrypt strings using RSA"
  s.description = "A gem that provides RSA based string encryption and decryption as well as storage of those strings"
  s.authors     = ["Michael Heijmans"]
  s.email       = 'parabuzzle@gmail.com'
  s.files       = ["lib/credstore.rb", "lib/credstore/crypt.rb", "lib/credstore/storage.rb"]
  s.homepage    = "https://github.com/parabuzzle/credstore"
end