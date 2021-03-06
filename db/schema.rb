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

ActiveRecord::Schema.define(version: 20_180_328_170_029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name'
    t.string 'region'
    t.string 'city'
    t.string 'address'
    t.datetime 'date'
    t.bigint 'organizer_id'
    t.text 'description'
    t.string 'link'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'event_image_file_name'
    t.string 'event_image_content_type'
    t.integer 'event_image_file_size'
    t.datetime 'event_image_updated_at'
    t.index ['organizer_id'], name: 'index_events_on_organizer_id'
  end

  create_table 'organizers', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
