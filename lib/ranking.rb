class Ranking
  def initialize(user)
    @user = user
  end

  def rank
    @user.logs
  end
end
