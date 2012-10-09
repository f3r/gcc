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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121009082037) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "city_old"
    t.string   "country"
    t.string   "zip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat",        :precision => 15, :scale => 12
    t.decimal  "lon",        :precision => 15, :scale => 12
    t.integer  "city_id"
  end

  create_table "alerts", :force => true do |t|
    t.integer  "user_id"
    t.string   "alert_type"
    t.text     "query"
    t.text     "results"
    t.string   "delivery_method", :default => "email"
    t.string   "schedule",        :default => "daily"
    t.boolean  "active",          :default => true
    t.string   "search_code"
    t.datetime "delivered_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "search_id"
  end

  add_index "alerts", ["user_id"], :name => "index_alerts_on_user_id"

  create_table "amenities", :force => true do |t|
    t.string   "name"
    t.boolean  "searchable"
    t.integer  "amenity_group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "amenity_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "prompt_text"
  end

  create_table "app_loggers", :force => true do |t|
    t.string   "url"
    t.string   "controller"
    t.string   "action"
    t.string   "method"
    t.text     "params"
    t.string   "user_id"
    t.string   "user_role"
    t.string   "user_email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ip_address"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "availabilities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.date     "date_start"
    t.date     "date_end"
    t.integer  "price_per_night"
    t.string   "comment"
    t.integer  "availability_type"
    t.integer  "transaction_id"
  end

  add_index "availabilities", ["place_id"], :name => "index_availabilities_on_place_id"
  add_index "availabilities", ["transaction_id"], :name => "index_availabilities_on_transaction_id"

  create_table "bank_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "holder_name"
    t.string   "holder_street"
    t.string   "holder_zip"
    t.string   "holder_state_name"
    t.string   "holder_city_name"
    t.string   "holder_country_name"
    t.string   "holder_country_code"
    t.string   "account_number"
    t.string   "bank_code"
    t.string   "branch_code"
    t.string   "iban"
    t.string   "swift"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.float   "lat"
    t.float   "lon"
    t.string  "state"
    t.string  "country"
    t.string  "country_code"
    t.string  "cached_complete_name"
    t.boolean "active",               :default => false
    t.integer "position"
    t.string  "slug"
    t.integer "geoname_id"
  end

  add_index "cities", ["country"], :name => "index_cities_on_country"
  add_index "cities", ["country_code"], :name => "index_cities_on_country_code"
  add_index "cities", ["slug"], :name => "index_cities_on_slug", :unique => true
  add_index "cities", ["state"], :name => "index_cities_on_state"

  create_table "cmspage_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "cmspage_menu_sections", :force => true do |t|
    t.integer  "cmspage_id"
    t.integer  "menu_section_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "position",        :default => 0
  end

  create_table "cmspage_versions", :force => true do |t|
    t.integer  "cmspage_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cmspages", :force => true do |t|
    t.string  "page_title"
    t.string  "page_url",                             :null => false
    t.text    "description"
    t.boolean "active",           :default => false
    t.boolean "mandatory",        :default => false
    t.string  "type",             :default => "Page", :null => false
    t.text    "meta_description"
    t.text    "meta_keywords"
  end

  add_index "cmspages", ["page_url"], :name => "index_cmspages_on_page_url", :unique => true

  create_table "cmspages_menu_sections", :id => false, :force => true do |t|
    t.integer  "cmspage_id"
    t.integer  "menu_section_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "position",        :default => 0
  end

  create_table "comments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "comment"
    t.boolean  "owner"
    t.integer  "replying_to"
    t.integer  "comments_count"
    t.integer  "product_id"
  end

  add_index "comments", ["place_id"], :name => "index_comments_on_place_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contact_requests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "conversations", :force => true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "sender_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "currencies", :force => true do |t|
    t.string  "name"
    t.string  "symbol"
    t.string  "country"
    t.string  "currency_code"
    t.boolean "active",                :default => false
    t.integer "position"
    t.string  "currency_abbreviation"
    t.boolean "default",               :default => false
  end

  create_table "custom_fields", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.string   "hint"
    t.integer  "type_cd"
    t.text     "values"
    t.string   "validations"
    t.boolean  "required"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "more_info_label"
    t.string   "date_format",     :limit => 20
    t.integer  "position",                      :default => 999999
    t.string   "prefix"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dj_clubs", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.text     "location"
    t.string   "website"
    t.string   "phone"
    t.integer  "points"
    t.boolean  "active",              :default => true
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.text     "address"
    t.string   "photo1_file_name"
    t.string   "photo1_content_type"
    t.integer  "photo1_file_size"
    t.datetime "photo1_updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "favorable_id"
    t.string   "favorable_type"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "favorites", ["favorable_id"], :name => "index_favorites_on_favorable_id"
  add_index "favorites", ["user_id"], :name => "index_favorites_on_user_id"

  create_table "front_carrousels", :force => true do |t|
    t.string   "link"
    t.string   "label"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "position"
    t.boolean  "active",             :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string   "name",                               :null => false
    t.integer  "transition_speed", :default => 1000
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "gallery_items", :force => true do |t|
    t.string   "link"
    t.string   "label"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "position",           :default => 0
    t.boolean  "active",             :default => true
    t.integer  "gallery_id",         :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "inbox_entries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "read",            :default => false
    t.datetime "deleted_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "inbox_entries", ["conversation_id"], :name => "index_inbox_entries_on_conversation_id"

  create_table "inquiries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.date     "check_in"
    t.date     "check_out"
    t.text     "extra"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "length_stay"
    t.string   "length_stay_type"
    t.integer  "guests"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "product_id"
    t.integer  "budget"
  end

  add_index "inquiries", ["place_id"], :name => "index_inquiries_on_place_id"
  add_index "inquiries", ["user_id"], :name => "index_inquiries_on_user_id"

  create_table "locales", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "name_native"
    t.integer "position"
    t.boolean "active",      :default => false
  end

  add_index "locales", ["code"], :name => "index_locales_on_code", :unique => true

  create_table "menu_sections", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "display_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "description"
  end

  add_index "menu_sections", ["name"], :name => "index_menu_sections_on_name", :unique => true

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.integer  "from_id"
    t.text     "body"
    t.boolean  "system"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "system_msg_id"
  end

  add_index "messages", ["conversation_id"], :name => "index_messages_on_conversation_id"

  create_table "panoramas", :force => true do |t|
    t.integer "product_id"
    t.string  "photo_file_name"
    t.text    "xml"
    t.string  "html_file_name"
    t.string  "swf_file_name"
  end

  create_table "payment_logs", :force => true do |t|
    t.integer "payment_id"
    t.string  "state"
    t.string  "previous_state"
    t.text    "additional_data"
  end

  create_table "payment_notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "params"
    t.string   "status"
    t.string   "txn_id"
    t.integer  "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "amount"
    t.text     "note"
    t.integer  "recipient_id"
    t.integer  "transaction_id"
    t.integer  "currency_id"
    t.datetime "pay_at"
    t.string   "state"
    t.datetime "added_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "place_id"
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "position"
    t.integer  "product_id"
  end

  create_table "place_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "published",                               :default => false
    t.string   "title"
    t.text     "description"
    t.integer  "place_type_id"
    t.integer  "num_bedrooms"
    t.integer  "num_beds"
    t.integer  "num_bathrooms"
    t.float    "size"
    t.integer  "max_guests"
    t.text     "photos_old"
    t.integer  "city_id"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zip"
    t.float    "lat"
    t.float    "lon"
    t.text     "directions"
    t.boolean  "amenities_aircon",                        :default => false
    t.boolean  "amenities_breakfast",                     :default => false
    t.boolean  "amenities_buzzer_intercom",               :default => false
    t.boolean  "amenities_cable_tv",                      :default => false
    t.boolean  "amenities_dryer",                         :default => false
    t.boolean  "amenities_doorman",                       :default => false
    t.boolean  "amenities_elevator",                      :default => false
    t.boolean  "amenities_family_friendly",               :default => false
    t.boolean  "amenities_gym",                           :default => false
    t.boolean  "amenities_hot_tub",                       :default => false
    t.boolean  "amenities_kitchen",                       :default => false
    t.boolean  "amenities_handicap",                      :default => false
    t.boolean  "amenities_heating",                       :default => false
    t.boolean  "amenities_hot_water",                     :default => false
    t.boolean  "amenities_internet",                      :default => false
    t.boolean  "amenities_internet_wifi",                 :default => false
    t.boolean  "amenities_jacuzzi",                       :default => false
    t.boolean  "amenities_parking_included",              :default => false
    t.boolean  "amenities_pets_allowed",                  :default => false
    t.boolean  "amenities_pool",                          :default => false
    t.boolean  "amenities_smoking_allowed",               :default => false
    t.boolean  "amenities_suitable_events",               :default => false
    t.boolean  "amenities_tennis",                        :default => false
    t.boolean  "amenities_tv",                            :default => false
    t.boolean  "amenities_washer",                        :default => false
    t.string   "currency"
    t.integer  "price_per_night"
    t.integer  "price_per_week"
    t.integer  "price_per_month"
    t.integer  "price_final_cleanup",                     :default => 0
    t.integer  "price_security_deposit",                  :default => 0
    t.integer  "price_per_night_usd"
    t.integer  "price_per_week_usd"
    t.integer  "price_per_month_usd"
    t.string   "check_in_after"
    t.string   "check_out_before"
    t.integer  "minimum_stay",                            :default => 0
    t.integer  "maximum_stay",                            :default => 0
    t.text     "house_rules"
    t.integer  "cancellation_policy",                     :default => 1
    t.float    "reviews_overall",                         :default => 0.0
    t.float    "reviews_accuracy_avg",                    :default => 0.0
    t.float    "reviews_cleanliness_avg",                 :default => 0.0
    t.float    "reviews_checkin_avg",                     :default => 0.0
    t.float    "reviews_communication_avg",               :default => 0.0
    t.float    "reviews_location_avg",                    :default => 0.0
    t.float    "reviews_value_avg",                       :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_final_cleanup_usd"
    t.integer  "price_security_deposit_usd"
    t.float    "size_sqm"
    t.float    "size_sqf"
    t.string   "size_unit"
    t.string   "city_name"
    t.string   "country_name"
    t.string   "state_name"
    t.string   "country_code",               :limit => 2
    t.float    "price_sqf_usd"
    t.string   "stay_unit"
  end

  add_index "places", ["amenities_aircon"], :name => "index_places_on_amenities_aircon"
  add_index "places", ["amenities_breakfast"], :name => "index_places_on_amenities_breakfast"
  add_index "places", ["amenities_buzzer_intercom"], :name => "index_places_on_amenities_buzzer_intercom"
  add_index "places", ["amenities_cable_tv"], :name => "index_places_on_amenities_cable_tv"
  add_index "places", ["amenities_doorman"], :name => "index_places_on_amenities_doorman"
  add_index "places", ["amenities_dryer"], :name => "index_places_on_amenities_dryer"
  add_index "places", ["amenities_elevator"], :name => "index_places_on_amenities_elevator"
  add_index "places", ["amenities_family_friendly"], :name => "index_places_on_amenities_family_friendly"
  add_index "places", ["amenities_gym"], :name => "index_places_on_amenities_gym"
  add_index "places", ["amenities_handicap"], :name => "index_places_on_amenities_handicap"
  add_index "places", ["amenities_heating"], :name => "index_places_on_amenities_heating"
  add_index "places", ["amenities_hot_tub"], :name => "index_places_on_amenities_hot_tub"
  add_index "places", ["amenities_hot_water"], :name => "index_places_on_amenities_hot_water"
  add_index "places", ["amenities_internet"], :name => "index_places_on_amenities_internet"
  add_index "places", ["amenities_internet_wifi"], :name => "index_places_on_amenities_internet_wifi"
  add_index "places", ["amenities_jacuzzi"], :name => "index_places_on_amenities_jacuzzi"
  add_index "places", ["amenities_kitchen"], :name => "index_places_on_amenities_kitchen"
  add_index "places", ["amenities_parking_included"], :name => "index_places_on_amenities_parking_included"
  add_index "places", ["amenities_pets_allowed"], :name => "index_places_on_amenities_pets_allowed"
  add_index "places", ["amenities_pool"], :name => "index_places_on_amenities_pool"
  add_index "places", ["amenities_smoking_allowed"], :name => "index_places_on_amenities_smoking_allowed"
  add_index "places", ["amenities_suitable_events"], :name => "index_places_on_amenities_suitable_events"
  add_index "places", ["amenities_tennis"], :name => "index_places_on_amenities_tennis"
  add_index "places", ["amenities_tv"], :name => "index_places_on_amenities_tv"
  add_index "places", ["amenities_washer"], :name => "index_places_on_amenities_washer"
  add_index "places", ["city_id"], :name => "index_places_on_city_id"
  add_index "places", ["city_name"], :name => "index_places_on_city_name"
  add_index "places", ["country_code"], :name => "index_places_on_country_code"
  add_index "places", ["country_name"], :name => "index_places_on_country_name"
  add_index "places", ["place_type_id"], :name => "index_places_on_place_type_id"
  add_index "places", ["state_name"], :name => "index_places_on_state_name"
  add_index "places", ["user_id"], :name => "index_places_on_user_id"

  create_table "preference_sections", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "position"
    t.boolean  "active",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "locale_id"
    t.integer  "currency_id"
    t.integer  "size_unit_id"
    t.integer  "speed_unit_id"
    t.integer  "city_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "product_amenities", :force => true do |t|
    t.integer "product_id"
    t.integer "amenity_id"
  end

  create_table "products", :force => true do |t|
    t.integer  "as_product_id"
    t.string   "as_product_type"
    t.integer  "user_id"
    t.boolean  "published"
    t.string   "title"
    t.text     "description"
    t.integer  "city_id"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zip"
    t.decimal  "lat",                 :precision => 15, :scale => 12
    t.decimal  "lon",                 :precision => 15, :scale => 12
    t.integer  "radius"
    t.integer  "currency_id"
    t.integer  "price_per_hour"
    t.integer  "price_per_hour_usd"
    t.integer  "price_per_week"
    t.integer  "price_per_week_usd"
    t.integer  "price_per_month"
    t.integer  "price_per_month_usd"
    t.integer  "price_sale"
    t.integer  "price_sale_usd"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.integer  "category_id"
    t.integer  "price_per_day"
    t.integer  "price_per_day_usd"
    t.string   "amenities_search"
    t.text     "custom_values"
    t.integer  "completed_steps",                                     :default => 0
    t.integer  "points"
    t.boolean  "pro_dj",                                              :default => true
  end

  create_table "properties", :force => true do |t|
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "num_bedrooms"
    t.integer  "num_beds"
    t.integer  "num_bathrooms"
    t.float    "size"
    t.integer  "max_guests"
    t.text     "directions"
    t.integer  "price_final_cleanup",        :default => 0
    t.integer  "price_security_deposit",     :default => 0
    t.integer  "price_final_cleanup_usd"
    t.integer  "price_security_deposit_usd"
    t.string   "check_in_after"
    t.string   "check_out_before"
    t.integer  "minimum_stay",               :default => 0
    t.integer  "maximum_stay",               :default => 0
    t.text     "house_rules"
    t.integer  "cancellation_policy",        :default => 1
    t.float    "size_sqm"
    t.float    "size_sqf"
    t.string   "size_unit"
    t.float    "price_sqf_usd"
    t.string   "stay_unit"
    t.integer  "place_id"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "score"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["product_id"], :name => "index_reviews_on_product_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "search_amenities", :force => true do |t|
    t.integer "search_id"
    t.integer "amenity_id"
  end

  create_table "search_categories", :force => true do |t|
    t.integer "search_id"
    t.integer "category_id"
  end

  create_table "searches", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "type"
    t.integer  "currency_id"
    t.integer  "city_id"
    t.integer  "min_price"
    t.integer  "max_price"
    t.string   "max_lat"
    t.string   "min_lat"
    t.string   "min_lng"
    t.string   "max_lng"
    t.integer  "guests",      :default => 1
    t.datetime "check_in"
    t.datetime "check_out"
    t.string   "sort_by"
  end

  create_table "services", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "education_status"
    t.string   "last_institute"
    t.string   "seeking"
    t.integer  "language_1_cd"
    t.integer  "language_2_cd"
    t.integer  "language_3_cd"
  end

  create_table "site_configs", :force => true do |t|
    t.string   "site_name"
    t.string   "site_url"
    t.string   "mailer_sender"
    t.string   "support_email"
    t.string   "gae_tracking_code"
    t.string   "fb_app_id"
    t.string   "fb_app_secret"
    t.string   "tw_app_id"
    t.string   "tw_app_secret"
    t.string   "mail_bcc"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "site_tagline"
    t.string   "static_assets_path"
    t.text     "custom_meta"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.text     "head_tag"
    t.text     "after_body_tag_start"
    t.text     "before_body_tag_end"
    t.string   "color_scheme",                 :default => "default"
    t.string   "logo_file_name"
    t.string   "photo_watermark_file_name"
    t.string   "photo_watermark_content_type"
    t.integer  "photo_watermark_file_size"
    t.datetime "photo_watermark_updated_at"
    t.string   "fav_icon_file_name"
    t.text     "sidebar_widget"
    t.boolean  "calendar",                     :default => true
    t.boolean  "enable_price_per_hour"
    t.boolean  "enable_price_per_day"
    t.boolean  "enable_price_per_week"
    t.boolean  "enable_price_per_month"
    t.boolean  "enable_price_sale"
    t.boolean  "agent_need_approval",          :default => true
    t.boolean  "panoramas",                    :default => false
    t.boolean  "photos",                       :default => true
    t.boolean  "enable_message_masking",       :default => true
    t.boolean  "charge_total",                 :default => false
    t.integer  "fee_amount",                   :default => 300
    t.boolean  "fee_is_fixed",                 :default => true
    t.integer  "fixed_radius"
    t.boolean  "show_contact",                 :default => true
    t.integer  "listing_photos_count",         :default => 0
    t.boolean  "show_powered",                 :default => true
    t.boolean  "show_all_amenities",           :default => true
    t.integer  "search_default_view_type_cd",  :default => 0
    t.string   "gae_tracking_code_tse"
  end

  create_table "transaction_logs", :force => true do |t|
    t.integer  "transaction_id"
    t.string   "state"
    t.string   "previous_state"
    t.text     "additional_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transaction_logs", ["transaction_id"], :name => "index_transaction_logs_on_transaction_id"

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.string   "state",                  :default => "bigbang"
    t.date     "check_in"
    t.date     "check_out"
    t.string   "currency"
    t.float    "price_per_night"
    t.float    "price_final_cleanup"
    t.float    "price_security_deposit"
    t.float    "service_fee"
    t.float    "service_percentage"
    t.float    "sub_total"
    t.text     "additional_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_code"
    t.integer  "inquiry_id"
  end

  add_index "transactions", ["place_id"], :name => "index_transactions_on_place_id"
  add_index "transactions", ["state"], :name => "index_transactions_on_state"
  add_index "transactions", ["user_id"], :name => "index_transactions_on_user_id"

  create_table "translation_versions", :force => true do |t|
    t.integer  "translation_id"
    t.text     "value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "translations", ["locale", "key"], :name => "index_translations_on_locale_and_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                                        :null => false
    t.string   "encrypted_password",        :limit => 128,                     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "timezone"
    t.string   "phone_mobile"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                                     :default => "user"
    t.string   "passport_number"
    t.string   "unconfirmed_email"
    t.string   "paypal_email"
    t.integer  "controls_user_id"
    t.boolean  "disabled",                                 :default => false
    t.string   "original_avatar_file_name"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

end
