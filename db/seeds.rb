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
puts 'Creating users...'
User.create!(email: 'roger@pizzeria.com', password: 'password', first_name: 'Roger', last_name: 'Smith')
User.create!(email: 'julien@pizzeria.com', password: 'password', first_name: 'Julien', last_name: 'Pineau')
puts 'Users created!'

# Projects
puts 'Creating projects...'
Project.create!(name: 'Pizzeria', description: 'A new pizzeria near you', user: User.first)
puts 'Projects created!'

# Boards
puts 'Creating boards...'
Board.create!(name: 'Todo', description: 'Task to do', project: Project.first)
Board.create!(name: 'In progress', description: 'Task in progress', project: Project.first)
Board.create!(name: 'Done', description: 'Task done', project: Project.first)
puts 'Boards created!'

# Labels
puts 'Creating labels...'
label_important = Label.create!(name: 'Important', color: '#FF474C', project: Project.first)
label_kitchen = Label.create!(name: 'Kitchen', color: '#3C47D3', project: Project.first)
label_supplies = Label.create!(name: 'Supplies', color: '#9327BB', project: Project.first)
puts 'Labels created!'

# To Do Tasks
puts 'Creating to do tasks...'
task_1 = Task.create!(name: 'Find nice tables', board: Board.first, deadline: Date.today + 1.week)
task_2 = Task.create!(name: 'Find chairs to sit on', board: Board.first, deadline: Date.today + 1.week)
task_3 = Task.create!(name: 'Order meat', board: Board.first, deadline: Date.today + 2.week)
task_4 = Task.create!(name: 'Order flour', board: Board.first, deadline: Date.today + 2.week)
task_5 = Task.create!(name: 'Order tomatoe', board: Board.first, deadline: Date.today + 2.week)
task_6 = Task.create!(name: 'Clean the windows', board: Board.first, deadline: Date.today + 3.week)
task_7 = Task.create!(name: 'Decorate the entrance', board: Board.first, deadline: Date.today + 3.week)
task_8 = Task.create!(name: 'Decorate the shop', board: Board.first, deadline: Date.today + 3.week)
task_9 = Task.create!(name: 'Create the menu', board: Board.first)
task_10 = Task.create!(name: 'Hire people', board: Board.first)
task_11 = Task.create!(name: 'Advertise on internet', board: Board.first)
puts 'To do tasks created!'


# In Progress Tasks
puts 'Creating in progress tasks...'
task_12 = Task.create!(name: 'Prepare the kitchen', board: Board.second)
task_13 = Task.create!(name: 'Order cheese', board: Board.second, deadline: Date.yesterday)
task_14 = Task.create!(name: 'Order sauce', board: Board.second, deadline: Date.yesterday)
task_15 = Task.create!(name: 'Do the paperwork', board: Board.second)
task_16 = Task.create!(name: 'Hire a chef', board: Board.second, deadline: Date.today + 1.week)
puts 'In progress tasks created!'

# Done Tasks
puts 'Creating done tasks...'
task_17 = Task.create!(name: 'Buy the place', board: Board.third)
task_18 = Task.create!(name: 'Pay the rent', board: Board.third, deadline: Date.today + 2.days)
puts 'Done tasks created!'

puts 'Creating task labels...'
# important label
TaskLabel.create!(task: task_1, label: label_important)
TaskLabel.create!(task: task_2, label: label_important)
TaskLabel.create!(task: task_10, label: label_important)
TaskLabel.create!(task: task_11, label: label_important)

# supplies label
TaskLabel.create!(task: task_3, label: label_supplies)
TaskLabel.create!(task: task_4, label: label_supplies)
TaskLabel.create!(task: task_5, label: label_supplies)
TaskLabel.create!(task: task_13, label: label_supplies)
TaskLabel.create!(task: task_14, label: label_supplies)

# kitchen label
TaskLabel.create!(task: task_12, label: label_kitchen)
TaskLabel.create!(task: task_16, label: label_kitchen)
TaskLabel.create!(task: task_17, label: label_kitchen)
TaskLabel.create!(task: task_18, label: label_kitchen)
puts 'Task labels created!'

# puts 'Creating project permissions...'


# # Subtask Groups
# SubtaskGroup.create!(name: 'Subtask Group 1', task: Task.first)
# SubtaskGroup.create!(name: 'Subtask Group 2', task: Task.second)

# # Subtasks
# Subtask.create!(name: 'Subtask 1', subtask_group: SubtaskGroup.first)
# Subtask.create!(name: 'Subtask 2', subtask_group: SubtaskGroup.second)

# # Assignees
# Assignee.create!(user: User.first, task: Task.first)
# Assignee.create!(user: User.second, task: Task.second)

# # Messages
# Message.create!(conference: Conference.first, user: User.first, content: 'Hello from user1')
# Message.create!(conference: Conference.second, user: User.second, content: 'Hello from user2')

puts 'Seeding complete!'
