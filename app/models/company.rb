class Company < ApplicationRecord
  before_create :generate_subdomain
  
  belongs_to :company_type
  belongs_to :payment_type
  
  belongs_to :primary_contact, class_name: 'User', foreign_key: 'user_id', optional: true
  
  belongs_to :title

  has_one :setting, dependent: :destroy
  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users
  has_many :messages, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :accidents, dependent: :destroy

  belongs_to :free_period
  
  validates_uniqueness_of :subdomain, :on => :create, :message => "must be unique"
  
  validates_presence_of :name
  validates_presence_of :company_type
  validates_presence_of :forename
  validates_presence_of :surname
  validates_presence_of :email
  
  validates_presence_of :payment_type

  cattr_accessor :current_id
  cattr_accessor :is_admin
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  
  
  private
  def generate_subdomain
    self.subdomain = self.name.parameterize.underscore.dasherize
  end
end
