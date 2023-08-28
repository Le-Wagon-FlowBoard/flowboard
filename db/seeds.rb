# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear existing data
# Clear existing data
Assignee.destroy_all
Subtask.destroy_all
SubtaskGroup.destroy_all
TaskLabel.destroy_all
Label.destroy_all
Message.destroy_all
ProjectPermission.destroy_all
Conference.destroy_all
Task.destroy_all
Board.destroy_all
Project.destroy_all
User.destroy_all

# Users
User.create!(email: 'user1@example.com', password: 'password', first_name: 'John', last_name: 'Doe')
User.create!(email: 'user2@example.com', password: 'password', first_name: 'Jane', last_name: 'Smith')

# Projects
Project.create!(name: 'Project 1', description: 'Description for Project 1', user: User.first)
Project.create!(name: 'Project 2', description: 'Description for Project 2', user: User.second)

# Boards
Board.create!(name: 'Board 1', description: 'Description for Board 1', project: Project.first)
Board.create!(name: 'Board 2', description: 'Description for Board 2', project: Project.second)

# Labels
Label.create!(name: 'Label 1', color: '#FF5733', project: Project.first)
Label.create!(name: 'Label 2', color: '#33FF57', project: Project.second)

# Conferences
Conference.create!(name: 'Conference 1', date: DateTime.now, project: Project.first)
Conference.create!(name: 'Conference 2', date: DateTime.now, project: Project.second)

# Task Labels
Task.create!(name: 'Task 1', description: 'Description for Task 1', board: Board.first)
Task.create!(name: 'Task 2', description: 'Description for Task 2', board: Board.second)

# Task Labels
TaskLabel.create!(task: Task.first, label: Label.first)
TaskLabel.create!(task: Task.second, label: Label.second)

# Subtask Groups
SubtaskGroup.create!(name: 'Subtask Group 1', task: Task.first)
SubtaskGroup.create!(name: 'Subtask Group 2', task: Task.second)

# Subtasks
Subtask.create!(name: 'Subtask 1', subtask_group: SubtaskGroup.first)
Subtask.create!(name: 'Subtask 2', subtask_group: SubtaskGroup.second)

# Assignees
Assignee.create!(user: User.first, task: Task.first)
Assignee.create!(user: User.second, task: Task.second)

# Messages
Message.create!(conference: Conference.first, user: User.first, content: 'Hello from user1')
Message.create!(conference: Conference.second, user: User.second, content: 'Hello from user2')

# Project Permissions
ProjectPermission.create!(project: Project.first, user: User.first, access: 'editor')
ProjectPermission.create!(project: Project.second, user: User.second, access: 'viewer')

puts 'Seeding complete!'
