class User < ApplicationRecord
  has_secure_password
  include EmailValidatable
    
  before_create :generate_access_token
  
  belongs_to :title, optional: true
  belongs_to :company
  belongs_to :unscoped_company, -> { unscoped }, foreign_key: :company_id, class_name: "Company"
  
  has_many :company_users, dependent: :destroy
  has_many :companies, through: :company_users
  
  has_many :videos, dependent: :destroy
  has_many :accidents, dependent: :destroy
    
  has_many :user_devices, dependent: :destroy
  has_many :user_events, dependent: :destroy
  
  validates_presence_of :company, :on => :create, :message => "can't be blank"  
  
  validates_presence_of :forename, :on => :create, :message => "can't be blank"
  validates_presence_of :surname, :on => :create, :message => "can't be blank"

  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :email
  validates :email, email: true
  
  accepts_nested_attributes_for :company_users
  
  before_save :check_company_users
    
  scope :has_iap, -> { joins(:user_events).where("user_events.event_type_const = 'IAP_PURCHASED'") }
  
  scope :has_license, -> { joins(:company_users).where("(company_users.start_date <= ? or company_users.start_date is null) and (company_users.end_date >= ? or company_users.end_date is null) and length(company_users.license_code) > 0", Date.today, Date.today) }

  scope :ios, -> { joins(:user_devices).where("user_devices.system_name = 'iOS'") }
  scope :android, -> { joins(:user_devices).where("user_devices.system_name = 'Android'") }
  
  def check_company_users
    company_users.each do |company_user|
      if company_user.create_license && (company_user.create_license == true || company_user.create_license == 1 || company_user.create_license == "1")
        company_user.license_code = SecureRandom.uuid
      end
      
      company_user.company_id = self.company_id
      company_user.save
    end
  end
  
  def self.company_secure
    if Company.is_admin == false
      where(company_id: Company.current_id)
    else
      all
    end
  end  

  def display_name
    [forename, surname].reject(&:blank?).join(' ')
  end

  def company_name
    companies.first.name
  end
  
  # TODO: Get the license info
  def has_license?
    license_company = company_users.active.find_by_company_id(self.company_id)
    if license_company && license_company.license_code && license_company.license_code.length > 0
      return true
    else
      return false
    end
  end


  def has_iap?
    self.user_events.where(event_type_const: "IAP_PURCHASED").count > 0
  end
  
  def is_company_admin?(company)
    return false if company.nil?

    company_user = company_users.find_by(company_id: company.id)
    company_user.present? && company_user.is_company_admin?
  end
  

  def set_password_reset_token
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
  end 
  
  private
  
  def self.to_csv
    attributes = %w{email forename surname promo_code created_at insurer telephone_number address}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map do |attr| 
        if attr == 'created_at'
          user.created_at.strftime("%d/%m/%Y %H:%M")
        else
          user.send(attr)
        end
      end
      end
    end
  end
    
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
  
  
end
