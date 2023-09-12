# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Clearing existing data
# User.destroy_all
# Post.destroy_all

#  users
user1 = User.create(username: 'john_doe', password: 'password123')
user2 = User.create(username: 'jane_doe', password: 'password123')

# posts
Post.create(title: 'First Blog Post', content: 'This is the content of the first blog post.', user: user1)
Post.create(title: 'Second Blog Post', content: 'This is the content of the second blog post.', user: user1)

Post.create(title: 'Jane\'s First Blog Post', content: 'This is Jane\'s first blog post content.', user: user2)