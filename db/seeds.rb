# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
Product.find_or_create_by "title"=>"Raspberry PI",
               "description"=>"Raspberry Pi 3 Model B 1GB Quad Core 1.2GHz 64bit CPU Wifi Bluetooth Starter Kit",
               "image_url"=>"http://i.ebayimg.com/images/g/-lsAAOSwubRXIYvb/s-l300.jpg",
               "price"=>34.5

Product.find_or_create_by "title"=>"Arduino UNO",
               "description"=>"Uno R3 Mega 328P Atmega 16U2 Placa de Desarrollo para Arduino + cable Usb SGHS",
               "image_url"=>"http://i.ebayimg.com/images/g/rqUAAOSwlfxXGltq/s-l500.jpg",
               "price"=> 4.5

