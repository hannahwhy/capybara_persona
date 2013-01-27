require 'fileutils'
require 'json'

class Authdb
  include FileUtils

  FILE = File.expand_path('../../../browserid/var/authdb.json', __FILE__)

  attr_reader :json

  def initialize
    @json = begin
              JSON.parse(File.read(FILE))
            rescue Errno::ENOENT
              {}
            end
  end

  def purge
    rm FILE
  end

  def verification_tokens_for(email)
    emails = json['stagedEmails']
    return nil unless emails

    emails.select { |e, _| email == e }.map(&:last)
  end
end
