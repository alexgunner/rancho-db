
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Payment.create(name: "Efectivo")
#Payment.create(name: "Tarjeta")

UserRole.create name: 'Cajero'
UserRole.create name: 'Contador'
UserRole.create name: 'Administrador'
UserRole.create name: 'Socio'
User.create email: "admin@admin.com", password: "adminadmin", password_confirmation: "adminadmin", branch_id: 1, user_role_id: 3

User.create email: "reghi2021@gmail.com", password: "reghi2019", password_confirmation: "reghi2019", branch_id: 1, user_role_id: 2
User.create email: "soloquiroga@gmail.com", password: "soloquiroga2019", password_confirmation: "soloquiroga2019", branch_id: 1, user_role_id: 4
User.create email: "saludcontigo@hotmail.com", password: "salud2019", password_confirmation: "salud2019", branch_id: 1, user_role_id: 4
User.create email: "mzavaleta@gmail.com", password: "mzavaleta2019", password_confirmation: "mzavaleta2019", branch_id: 1, user_role_id: 4






