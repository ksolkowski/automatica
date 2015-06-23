namespace :automatica do

  task sync_trips: :environment do
    Car.all.each(&:sync_trips)
  end

end