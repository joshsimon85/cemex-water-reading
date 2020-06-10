admin = User.create({
  :full_name => 'Jon Doe',
  :email => 'jon@testing.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => true
})
