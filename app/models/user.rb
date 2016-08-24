class User < ActiveRecord::Base
  include AASM
=begin
  has_many :memberships
  has_many :active_memberships,  ->{where(aasm_state: "active")},   class_name: 'Membership'
  has_many :membership_requests, ->{where(aasm_state: "requested")},class_name: 'Membership'
  has_many :disabled_memberships,->{where(aasm_state: "disabled")}, class_name: 'Membership'

  has_many :organizations, through: :active_memberships
  has_many :group_users, ->(object) {where(user: object.id)}, through: :active_memberships

  has_many :groups,     -> { distinct }, through: :group_users
  has_many :group_cruds,-> { distinct }, through: :groups
  has_many :projects,   -> { distinct }, through: :groups

  has_many :workflow_performer_groups,-> { distinct }, through: :groups
  has_many :workflow_manager_groups,  -> { distinct }, through: :groups

  has_many :udts, -> { distinct }, through: :groups
  has_many :workflows, -> { distinct }, through: :udts
  #has_many :workflow_performers, through: :workflows


  #  def overdue
  #    where("date
  #where("due_date_for_task > ?", 24.hours.ago).count
  #  end
  #  def newly_assigned
  #    #where("? > due_date_for_task  ?? 1.day.ago
  #  end
  #end
  #alias_method  :label, :name

  has_many :wf_events, through: :workflows, class_name: 'Workflow::Event', source: :events
  has_many :wf_states, through: :workflows, class_name: 'Workflow::State', source: :states
  has_many :project_manager_roles, class_name: 'ProjectManager'

  has_paper_trail

  serialize :config_list_sort
  has_many :list_configurations
=end

  has_many :term_search_logs  #
  has_many :searched_terms, through: :term_search_logs, source: :term

  geocoded_by :postal_code, latitude: :lat, longitude: :lng  do |obj,results|
    if geo = results.first
      obj.lat = geo.latitude
      obj.lng = geo.longitude
      obj.postal_code = geo.address
    end
  end
  after_validation :geocode, if: ->(obj){ obj.postal_code.present? and obj.postal_code_changed? }


  # validations
  #validates :provider, :uid, :name,  presence: true #:oauth_token, :image_url, presence: true

  # this validations are checked when updating user because can be nil when we authenticate through twitter
  validates :email, uniqueness: true, presence: true,
    format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]+\z/i }, :on => :update
  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  #validates :gender, presence: true, on: :update
  #validates_uniqueness_of :uid

  aasm do
      state :guest, :initial => true
      state :updated_profile
      state :trusted
      state :banned
      state :removed

      event :profile_updated do
        transitions :from => [:guest,:updated_profile], :to => :updated_profile
      end
      event :trust do
        transitions :from => [:updated_profile, :banned, :removed], :to => :trusted
      end
      event :banned do
        transitions :from => [:running, :cleaning], :to => :sleeping
      end
  end

  def self.from_omniauth(auth)
    uidnumber = auth['extra']['raw_info'][:uidnumber].first
    find_by_provider_and_uid(auth["provider"], uidnumber) || create_with_omniauth(auth)
  end

  def full_name
    "#{first_name} #{last_name}" rescue nil
  end
  alias_method :label, :full_name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      #user.uid = auth["uid"]
      user.uid = auth['extra']['raw_info'][:uidnumber].first
      user.name = auth['extra']['raw_info'][:displayname].first
      #user.name = auth["info"]["name"]
      user.email = auth["info"]["email"] # nil when provider = twitter
      user.first_name = auth["info"]["first_name"] # nil when provider = twitter
      user.last_name = auth["info"]["last_name"] # nil when provider = twitter
      user.gender = auth["extra"]["raw_info"]["gender"] # nil when provider = twitter
      user.image_url = auth["info"]["image"]
      user.oauth_token = auth["credentials"]["token"]
    end
  end

  def to_param
   "#{id}-#{name.try(:parameterize)}"  if id
  end

end
