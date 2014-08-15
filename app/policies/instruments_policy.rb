class InstrumentsPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    current_user.has_role? :admin
  end

  def new?
    create?
  end

  def update?
    current_user.has_role? :admin
  end

  def edit?
    update?
  end

  def destroy?
    current_user.has_role? :admin
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

