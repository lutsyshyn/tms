# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Department.create(name: "Sales")
Department.create(name: "Support")
Department.create(name: "Billing")

Status.create(name: "Waiting for Staff Response")
Status.create(name: "Waiting for Customer")
Status.create(name: "On hold")
Status.create(name: "Canceled")
Status.create(name: "Completed")


Menu.create(name: "Show All", status_ids: [1,2,3,4,5], position: 1)
Menu.create(name: "Open", status_ids: [1,2,3], position: 3)
Menu.create(name: "Closed", status_ids: [4,5], position: 5)
Menu.create(name: "On hold", status_ids: [3], position: 4)
Menu.create(name: "Unassigned", status_ids: [1], show_without_user: true, position: 2)


User.create(username: "test", email: "admin@example.com", password: "123456", password_confirmation: "123456")

text = %w[Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut
          labore et dolore magna aliqua Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi
          ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse
          cillum dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa
          qui officia deserunt mollit anim id est laborum]

50.times do
  subject = []
  customer_name = []
  body = []
  rand(2..5).times {subject << text[rand(text.length)]}
  customer_email = text[rand(text.length)].downcase + "@example.com"
  2.times {customer_name << text[rand(text.length)].capitalize}
  department_id = rand(1..3)
  rand(10..40).times {body << text[rand(text.length)]}
  status_id = rand(1..5)

  Ticket.create(subject: subject.join(" "), customer_email: customer_email, customer_name: customer_name.join(" "),
  department_id: department_id, body: body.join(" "), status_id: status_id)

end