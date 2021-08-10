namespace :dev do
  desc "Configures the development environment"
  task setup: :environment do
    if Rails.env.development?
      
      plot_with_load('Deleting Database') { %x(rails db:drop) }
      plot_with_load('Creating Database') { %x(rails db:create) }
      plot_with_load('Migrating Tables') { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)

    else
      puts "You don't are in development environment"
    end
  end
  
  desc "add the coins"
  task add_coins: :environment do
    plot_with_load('Seeding Datas') do
      coins = [
              {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "http://pngimg.com/uploads/bitcoin/small/bitcoin_PNG47.png",
                mining_type: MiningType.find_by(acronym: 'PoW')
              },
              {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://w7.pngwing.com/pngs/993/2/png-transparent-ethereum-bitcoin-cryptocurrency-blockchain-logo-bitcoin-angle-triangle-logo.png",
                mining_type: MiningType.find_by(acronym: 'PoW')
              },
              {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://pngimage.net/wp-content/uploads/2018/05/dash-coin-logo-png-4.png",
                mining_type: MiningType.find_by(acronym: 'PoW')
              }
            ]
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "add the mining types"
  task add_mining_types: :environment do
    plot_with_load('Seeding Mining Types') do
      mining_types = [
              {
                description: "Proof of Work",
                acronym: "PoW",
              },
              {
                description: "Proof of Stake",
                acronym: "PoS",
              },
              {
                description: "Proof of Capacity",
                acronym: "PoC",
              }
            ]
      mining_types.each do |mt|
        MiningType.find_or_create_by!(mt)
      end
    end
  end

  private
    def plot_with_load(messenge_entry, messenge_out=' (Done!)')
    
      spinner = TTY::Spinner.new("[:spinner] #{messenge_entry} ...", format: :pong)
      spinner.auto_spin
      yield
      spinner.success("#{messenge_out}")
    
    end
end
