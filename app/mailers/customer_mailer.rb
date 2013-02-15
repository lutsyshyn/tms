class CustomerMailer < ActionMailer::Base

  default from: "staff@example.com"

  def ticket_submitted(ticket)
    @ticket = ticket
    @url  = ticket_url(ticket)
    mail(:to => ticket.customer_email, :subject => "You have submitted a ticket")
  end

  def ticket_read(ticket)
    @ticket = ticket
    @url  = ticket_url(ticket)
    mail(:to => ticket.customer_email, :subject => "Your ticket was read")
  end

  def ticket_responded(response)
    @response = response
    @url  = ticket_url(response.ticket)
    mail(:to => response.ticket.customer_email, :subject => "Your ticket was processed")
  end

end
