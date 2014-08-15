class InstrumentPolicy
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
    @user.has_role? :admin
  end

  def new?
    create?
  end

  def update?
    @user.has_role? :admin
  end

  def edit?
    update?
  end

  def destroy?
    @user.has_role? :admin
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

