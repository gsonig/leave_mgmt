class ResponsibleMailer < ActionMailer::Base
  default from: "ResponsibleMailer@grepruby.com"
    def leave(user,leave)
       @user = user
       @leave = leave
        mail(:to => user.email, :subject => "Leaved Update")
    end
end
