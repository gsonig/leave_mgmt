class ResponsibleMailer < ActionMailer::Base
  default from: "ResponsibleMailer@grepruby.com"
  def leave(user,leave)
		emails = Array.new
		emails =["sourabh.ukkalgaonkar@gmail.com",user]
        @leave = leave
        mail(:to => emails, :subject => "Leaved Update")
  end
end
