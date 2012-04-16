require 'base64'
require 'json'
require 'openssl'

class FacebookAuthentication
  def self.base64_url_decode(encoded_url)
    encoded_url += '=' * (4 - encoded_url.length.modulo(4))
    Base64.decode64(encoded_url.gsub('-', '+').gsub('_', '/'))
  end

  def self.parse_signed_request(signed_request, application_secret, max_age = 3600)
    encoded_signature, encoded_json = signed_request.split('.', 2)
    json = JSON.parse(base64_url_decode(encoded_json))
    encryption_algorithm = json['algorithm']

    raise 'Unsupported encryption algorithm.' \
      if encryption_algorithm != 'HMAC-SHA256'

    raise 'Signed request too old.' \
      if json['issued_at'] < Time.now.to_i - max_age

    raise 'Invalid signature.' \
      if base64_url_decode(encoded_signature) !=
          OpenSSL::HMAC.hexdigest('sha256', application_secret, encoded_json).split.pack('H*')

    return json
  end
end

