# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

XERO_CONFIG = YAML.load_file("#{::Rails.root}/config/xero.yml")[::Rails.env]
ADMIN = YAML.load_file("#{::Rails.root}/config/admin.yml")[::Rails.env]
SETTINGS = YAML.load_file("#{::Rails.root}/config/settings.yml")[::Rails.env]

Admin.create!(
  email: ADMIN['email'],
  password: ADMIN['password'],
  password_confirmation: ADMIN['password_confirmation']
) unless Admin.first

Setting.create!(
  consumer_key: XERO_CONFIG['consumer_key'],
  consumer_secret: XERO_CONFIG['consumer_secret'],
  api_token: SETTINGS['api_token'],
  prompa_url: SETTINGS['prompa_url'],
) unless Setting.first