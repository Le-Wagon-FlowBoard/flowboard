puts 'Destroying assignees...'
Assignee.destroy_all
puts 'Destroying subtasks...'
Subtask.destroy_all
puts 'Destroying subtask groups...'
SubtaskGroup.destroy_all
puts 'Destroying task labels...'
TaskLabel.destroy_all
puts 'Destroying labels...'
Label.destroy_all
puts 'Destroying project permissions...'
ProjectPermission.destroy_all
puts 'Destroying tasks...'
Task.destroy_all
puts 'Destroying boards...'
Board.destroy_all
puts 'Destroying messages...'
Message.destroy_all
puts 'Destroying projects...'
Project.destroy_all
puts 'Destroying users...'
User.destroy_all

# Users
puts 'Creating users...'
user1 = User.create!(email: 'roger@pizzeria.com', password: 'password', first_name: 'Roger', last_name: 'Smith')
user2 = User.create!(email: 'julien@pizzeria.com', password: 'password', first_name: 'Julien', last_name: 'Pineau')
user3 = User.create!(email: 'amelie@belle-piscines.fr', password: 'password', first_name: 'Amélie', last_name: 'Dupont')
user4 = User.create!(email: 'aurelien@carrent.fr', password: 'password', first_name: 'Aurélien', last_name: 'Lambert')
puts 'Users created!'

# Projects
puts 'Creating projects...'
project1 = Project.create!(name: 'Pizzeria', description: 'A new pizzeria near you', user: User.first)
puts 'Projects created!'

# Boards
puts 'Creating boards...'
board1 = Board.create!(name: 'Todo', description: 'Task to do', project: Project.first)
board2 = Board.create!(name: 'In progress', description: 'Task in progress', project: Project.first)
board3 = Board.create!(name: 'Done', description: 'Task done', project: Project.first)
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

puts 'Creating project permissions...'
ProjectPermission.create!(user: user3, project: project1)
puts 'Project permissions created!'

puts 'Creating assignees...'
Assignee.create!(user: user1, task: task_1)
Assignee.create!(user: user3, task: task_1)
Assignee.create!(user: user1, task: task_2)
Assignee.create!(user: user3, task: task_2)
Assignee.create!(user: user3, task: task_3)
Assignee.create!(user: user1, task: task_4)
Assignee.create!(user: user3, task: task_13)
Assignee.create!(user: user3, task: task_14)
Assignee.create!(user: user1, task: task_17)
Assignee.create!(user: user3, task: task_18)
puts 'Assignees created!'

puts 'Creating messages...'
# create a small conversation with user1 and user3 on project1
Message.create!(content: 'Hello, how are you? 👋', user: user1, project: project1)
Message.create!(content: 'I am fine, thanks! 😁', user: user3, project: project1)
Message.create!(content: 'What about you?', user: user3, project: project1)
Message.create!(content: 'I am fine too, thanks!', user: user1, project: project1)
Message.create!(content: 'What kind of tables do we need ? 🤔', user: user3, project: project1)
Message.create!(content: 'I think we need 10 tables for 4 people and 5 tables for 2 people, as for the chairs we need 50 chairs', user: user1, project: project1)
Message.create!(content: 'Ok, I will order them', user: user3, project: project1)
Message.create!(content: 'Great, thanks!', user: user1, project: project1)
Message.create!(content: 'I will order the meat and the flour', user: user1, project: project1)
Message.create!(content: 'By the way, did you found anynone to hire?', user: user1, project: project1)
Message.create!(content: 'We need someone that can cook pizzas but that also knows how to make pasta', user: user1, project: project1)
puts 'Messages created!'

puts 'Seeding complete!'
