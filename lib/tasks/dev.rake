# frozen_string_literal: true

namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    puts 'Iniciando Tarefas com o Banco de Dados...'
    %x(rails db:drop db:create db:migrate db:seed)

    puts 'Cadastrando os Tipos de Contatos...'

    kinds = %w[Amigo Comercial Conhecido]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts 'Tipos de Contatos Cadastrados com Sucesso'

    puts '###############################################################'

    puts 'Cadastrando os Contatos...'

    100.times do |_i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.days.ago, to: 12.days.ago),
        kind: Kind.all.sample
      )
    end

    puts 'Contatos Cadastrados com Sucesso'

    puts '###############################################################'

    puts 'Cadastrando os Telefones...'

    Contact.all.each do |contact|
      Random.rand(5).times do |_i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    puts 'Telefones Cadastrados com Sucesso'

    puts '###############################################################'

    puts 'Cadastrando os Endereços...'

    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts 'Endereços Cadastrados com Sucesso'

    puts '###############################################################'
  end
end
