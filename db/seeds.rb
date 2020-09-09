# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
boards = [
    { id: 0, name: 'board1'},
    { id: 1, name: 'board2'}
]

lists = [
    { id: 0, name: 'list1-2', board_id: 0, index: 1},
    { id: 1, name: 'list1-1', board_id: 0, index: 0},
    { id: 2, name: 'list1-3', board_id: 0, index: 2}
]

items = [
    { id: 0, name: 'item1-1-1', detail: 'Hello World!', list_id: 1, index: 0},
    { id: 3, name: 'item1-2-3', detail: 'Hoge', list_id: 0, index: 1},
    { id: 4, name: 'item1-2-2', detail: 'Huga', list_id: 0, index: 0},
    { id: 2, name: 'item1-1-3', detail: 'Piyo', list_id: 1, index: 2},
    { id: 1, name: 'item1-1-2', detail: '', list_id: 1, index: 3}
]

ActiveRecord::Base.transaction do
    Board.destroy_all
    List.destroy_all
    Item.destroy_all
    boards.each do |board|
        Board.create!(board)
    end
    lists.each do |list|
        List.create!(list)
    end
    items.each do |item|
        Item.create!(item)
    end
end