# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
    { id: 1, email: 'hoge@hoge.jp', password: 'hogehoge'},
    { id: 2, email: 'fuga@fuga.jp', password: 'fugafuga'}
]

boards = [
    { id: 1, name: 'board1'},
    { id: 2, name: 'board2'}
]

lists = [
    { id: 1, name: 'list1-1', board_id: 1, index: 1},
    { id: 2, name: 'list1-2', board_id: 1, index: 2},
    { id: 3, name: 'list1-3', board_id: 1, index: 3},
    { id: 4, name: 'list2-1', board_id: 2, index: 1},
    { id: 5, name: 'list2-2', board_id: 2, index: 2},
    { id: 6, name: 'list2-3', board_id: 2, index: 3},
    { id: 7, name: 'list2-4', board_id: 2, index: 4},
    { id: 8, name: 'list2-5', board_id: 2, index: 5}
]

items = [
    { id: 1, name: 'item1-1-1', detail: 'Hello World!', list_id: 1, index: 1},
    { id: 2, name: 'item1-1-2', detail: '', list_id: 1, index: 2},
    { id: 3, name: 'item1-1-3', detail: 'Piyo', list_id: 1, index: 3},
    { id: 4, name: 'item1-2-1', detail: 'Hoge', list_id: 2, index: 1},
    { id: 5, name: 'item1-2-2', detail: 'Huga', list_id: 2, index: 2}
]

assignments = [
    { id:1, user_id: 1, board_id: 1},
    { id:2, user_id: 1, board_id: 2},
    { id:3, user_id: 2, board_id: 2}
]

ActiveRecord::Base.transaction do
    User.destroy_all
    Board.destroy_all
    List.destroy_all
    Item.destroy_all
    Assignment.destroy_all

    users.each do |user|
        User.create!(user)
    end
    boards.each do |board|
        Board.create!(board)
    end
    lists.each do |list|
        List.create!(list)
    end
    items.each do |item|
        Item.create!(item)
    end
    assignments.each do |assignment|
        Assignment.create!(assignment)
    end
end