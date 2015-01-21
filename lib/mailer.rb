module Mailer

  def email(user,leave)
    emails = Array.new
    if user.responsibles.present?       
      responsible_user = user.responsibles
      responsible_user.each do |responsible|  
      users = User.find(responsible.responsible_id)
      emails = users.email                                    
    end
      ResponsibleMailer.leave(emails,leave).deliver       
    else
      ResponsibleMailer.leave("dinesh@gmail.com",leave).deliver           
    end
  end
end
