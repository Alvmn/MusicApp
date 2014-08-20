class CommentPolicy
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
    !@user.blank?
  end

  def new?
    create?
  end

  def update?
    !@user.blank? && @record.user == @user
  end

  def edit?
    update?
  end

  def destroy?
    @user == @record.user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

