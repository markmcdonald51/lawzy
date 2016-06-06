
class Ability
=begin
  include CanCan::Ability

  def as_action_aliases
    alias_action :list, :show_search, :render_field, :to => :read
    alias_action :update_column, :edit_associated, :new_existing, :add_existing, :to => :update
    alias_action :delete, :destroy_existing, :to => :destroy
  end

  UDT_CRUD_NAMES_TO_ABILTIES = {
    creatable:  :create,
    readable:   :read,
    updatable:  :update,
    deletable:  :delete
    # deletable:  :destroy
  }

  BELONGS_TO_ORG_CLASSES = [Project]
  HAS_ONE_ORG_CLASSES = [Udt, Group, GroupCrud, UdtValidationHelper, UdtTableField, UdtField]

  def initialize(current_user)
    @current_user = current_user
    able = []
    cancan_abilities = []

    #cannot [:manage, :update,:read, :create], :all
  #  cannot [:update,:read, :create], Udt.all.map(&:to_udt_model)
  #  binding.pry
    as_action_aliases # rescue nil  # TODO: remove nil

    udt_assoc_poly_references = {}

    @current_user.group_cruds.map(&:udt).each do |u|
      u.udt_associations.map(&:udt).each do |a|
        #binding.pry if a.blank?
        udt_assoc_poly_references[a.db_table_name] ||= []
        udt_assoc_poly_references[a.db_table_name] << u.udt_class_name #u.db_table_name.classify
      end
    end

    @current_user.group_cruds.each do |c|
      udt_class = c.udt.udt_class_name
      db_table_name = c.udt.db_table_name
      #lemme_see = []
      project_abilties = []
      UDT_CRUD_NAMES_TO_ABILTIES.map{|k,v| project_abilties << v if c.send(k)  }
      type_name = c.udt.udt_polymorphic_name

      if udt_assoc_poly_references[db_table_name]
        can project_abilties, udt_class.classify.constantize,
          :"#{type_name}_type"  => udt_assoc_poly_references[db_table_name],
          :"#{type_name}_id"    => udt_class.constantize.all.map(&:"#{type_name}_id")

        lemme_see = "can #{project_abilties}, #{udt_class.classify.constantize},
         :#{type_name}_type =>  #{udt_assoc_poly_references[udt_class]}, :#{type_name}_id => #{udt_class.classify.constantize.all.map(&:"#{type_name}_id")}"

      else
        lemme_see = "can #{project_abilties}, #{udt_class.classify.constantize}"
        can project_abilties, udt_class.constantize
      end

      #puts lemme_see
      able << lemme_see
    end

    @current_user ? user_rules(@current_user) : guest_rules

  end

  def user_rules(user)
    if @current_user.is_application_administrator?
      can :manage, :all
    else

      # SET PROJECT MANAGER ROLES HERE
      #@current_user.active_memberships

      @current_user.active_memberships.each do |membership|
        membership.roles.each do  |role|
          exec_role_rules(membership.organization, role)
        end
      end
    end
    default_user_rules
  end

  # This is the bare minium things that each user needs to be able to to with this
  # application.

  def guest_rules
  end

  def default_user_rules
    can [:read, :update], User, id: @current_user.id
  end

  def exec_role_rules(organization, role = 'guest')
    meth = :"#{role}_rules"
    send(meth, organization) if respond_to? meth
  end

  def regular_user_rules(organization)
    can :read, Organization,  id: organization.id
    can [:read, :update], User, id: @current_user.id
    can [:read], Project,
      organization_id:  organization.id,
      groups:           {id: @current_user.group_ids}
  end

  def project_manager_rules(organization)
    set_project_manager_role
  end

  def set_project_manager_role

    active_member_org_ids = @current_user.active_memberships.pluck(:organization_id)

    pids = @current_user.project_roles_of_organizations.select{|r|
      active_member_org_ids.include?(r.organization.id)}.map(&:organization).map(&:project_ids).flatten

    return unless pids.present?

    can :manage, Project, id: pids
    can :manage, Group, project: {id: pids}
    can :manage, Udt,project:   {id: pids}
    can :manage, User#, id: @current_user.id
    can :manage, GroupCrud, project:  {id: pids}
    can :manage, Group, project: {id: pids}

    can :manage, GroupPerformer
    can :manage, UdtField, project: {id: pids}
    can :manage, UdtTableField, project: {id: pids}

    can :read, Workflow, project: {id: pids}
    can :manage, Workflow::StateTransition, project: {id: pids}
    can :manage, Workflow::Event, project: {id: pids}
    can :manage, Workflow::State, project: {id: pids}
    can :manage, UdtImportMap, project: {id: pids}
    can :manage, UdtAssociation , project: {id: pids}
    can :manage, LabelField, project: {id: pids}
    can :read, Organization, id: @current_user.organization_ids
    #can :manage, Membership, project: {id: project.id}

  end

  def organization_admin_rules(organization)
    can :manage, Organization,  id: organization.id
    can :manage, OrganizationRoleUser, organization: {id: [organization.id]}
    can :manage, Person, contactable_type: 'Organization', contactable_id: organization.id
    can :manage, WhiteList
    can :manage, User#, organizations: {id: [organization.id]}
    can :manage, User, id: @current_user.id
    can :manage, GroupCrud #, organization: {id: organization.id}
    can :manage, Group, organization: {id: [organization.id]}

    can :manage, GroupPerformer
    can :manage, UdtField, organization: {id: [organization.id]}
    can :manage, UdtTableField,organization: {id: [organization.id]}
    can :manage, Project, organization_id: organization.id

    can [:manage, :build_udf, :update_table_state, :search_published_fields,
      :download_import_template], Udt, organization: {id: [organization.id]}
    can :manage, UdtAssociable, organization_id: organization.id

    can :manage, Workflow, organization: {id: [organization.id]}
    can :manage, AasmScript  #, organization: {id: organization.id}

    can :manage, Workflow::StateTransition#, organization: {id: [organization.id]}
    can :manage, Workflow::Event#, organization: {id: [organization.id]}
    can :manage, Workflow::State#, organization: {id: @current_user.organization_ids} # [organization.id]}

    can :manage, UdtImportMap, organization: {id: [organization.id]}
    can :manage, UdtAssociation, organization: {id: [organization.id]}
    can :manage, LabelField, organization: {id: [organization.id]}
    can :manage, Membership, organization_id: organization.id

    organization.udts.each do |u|
      can :manage, u.to_udt_model
    end



=end

end
