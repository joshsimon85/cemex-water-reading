admin = User.create({
  :full_name => 'Jon Doe',
  :email => 'jon@doe.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => true
})

user = User.create({
  :full_name => 'Jane Doe',
  :email => 'jane@doe.com',
  :password => 'password',
  :confirmed_at => Time.now,
  :admin => false
})

reading_1 = WaterMeterReading.create({
  :user => admin,
  :reading => 3200.9,
})

reading_1.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_2 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_2.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_3 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_3.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_4 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_4.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_5 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_5.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_6 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_6.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_7 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_7.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_8 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_8.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_9 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_9.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_10 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_10.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')

reading_11 = WaterMeterReading.create({
  :user => user,
  :reading => 3201.10,
})

reading_11.image.attach(io: File.open('./spec/support/assets/test_image.jpeg'), filename: 'test_image.jpeg')
