admin = User.create({
  :full_name => 'Jon Doe',
  :email => 'jon@doe.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => true,
  :suspended => false
})

user = User.create({
  :full_name => 'Jane Doe',
  :email => 'jane@doe.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => false,
  :suspended => false
})

suspended_user = User.create({
  :full_name => 'Suspended User',
  :email => 'suspended@user.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => false,
  :suspended => true
})

reading_1 = WaterMeterReading.new({
  :user => admin,
  :reading => 3200.9
})

reading_1.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_1.save

reading_2 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_2.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_2.save

reading_3 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_3.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_3.save

reading_4 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_4.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_4.save

reading_5 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.1
})

reading_5.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_5.save

reading_6 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_6.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_6.save

reading_7 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_7.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_7.save

reading_8 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_8.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_8.save

reading_9 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_9.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_9.save

reading_10 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_10.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_10.save

reading_11 = WaterMeterReading.new({
  :user => user,
  :reading => 3201.10
})

reading_11.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
reading_11.save
