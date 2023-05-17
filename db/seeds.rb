# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
 email: 'test@tests.com',
 password: 'password',
 )

User.create!(
 email: 'hou001@cmail.com',
 password: 'password',
 name: '一郎',
 introduction: "Hello, I'm User 1",
 flag: false
 )

 User.create!(
 email: 'hou002@cmail.com',
 password: 'password',
 name: '二郎',
 introduction: "Hello, I'm User 2",
 flag: false
 )

User.create!(
 email: 'hou003@cmail.com',
 password: 'password',
 name: '三郎',
 introduction: "Hello, I'm User 3",
 flag: false
 )

