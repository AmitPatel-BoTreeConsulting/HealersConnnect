namespace :pranic do
  desc 'Set registration_date to created_at for existing data if registration_date is null'
  task :set_registrations => :environment do
    Registration.where(registration_date: nil).update_all('registration_date = created_at')
    puts 'Migration for setting registration_date complete.'
  end
end