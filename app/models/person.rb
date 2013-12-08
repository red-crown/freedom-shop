require 'digest/sha2'

class Person < ActiveRecord::Base
  attr_reader :password

  ENCRYPT = Digest::SHA256

  has_many :sessions, :dependent => :destroy

  validates_uniqueness_of :name, :message => "is already used by another person"
  validates_format_of :password, :with => /\A([\x20-\x7E]){4,16}\z/,
    :message => "must be 4 to 16 characters",
    :unless => :password_is_not_being_updated?

  validates_confirmation_of :password

  before_save :scrub_name
  after_save :flush_passwords

  def self.find_by_name_and_password(name, password)
    person = self.find_by_name(name)
    if person and person.encrypted_password = ENCRYPT.hexdigest(password + person.salt)
      return person
    end
  end

  def password=(password)
    @password = password
    unless password_is_not_being_updated?
      self.salt, self.encrypted_password = Person.hash(password)
    end
  end

  def self.hash(password)
      salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
      encrypted_password = ENCRYPT.hexdigest(password + salt)

      return salt, encrypted_password
  end

  private

  def scrub_name
    self.name.downcase!
  end

  def flush_passwords
    @password = @password_confirmation = nil
  end

  def password_is_not_being_updated?
    self.id and self.password.blank?
  end

end
