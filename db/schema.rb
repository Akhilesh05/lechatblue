# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140320124934) do

  create_table "orders", force: true do |t|
    t.string   "pizza_id"
    t.string   "name"
    t.integer  "phone"
    t.string   "address"
    t.string   "city"
    t.string   "pizza_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_code"
    t.boolean  "confirmed",         limit: 255
    t.string   "client_ip"
    t.string   "msg_id"
    t.boolean  "msg_delivered"
    t.boolean  "resent"
  end

  create_table "pizzas", force: true do |t|
    t.string   "name"
    t.text     "ingredients"
    t.text     "description"
    t.string   "price"
    t.boolean  "available"
    t.integer  "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "veg"
    t.string   "add_ons"
  end

  create_table "roasted_chickens", force: true do |t|
    t.string   "name"
    t.text     "ingredients"
    t.text     "description"
    t.float    "price"
    t.boolean  "available"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
