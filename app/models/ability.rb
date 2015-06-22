class Ability
  include CanCan::Ability

    def initialize(user)

       user ||= User.new
         pod.user == user
       end

       can :manage, Comment do |comment|
         comment.pod.user == user || comment.user == user
       end


    end
end
