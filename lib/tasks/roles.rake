namespace :roles do
  desc 'Create default roles'
  puts 'started creation of roles'
  task create: :environment do
    default_roles = %w[super_user admin developer scrum_master manager]

    default_roles.each do |role_name|
      Role.find_or_create_by(name: role_name)
    end

    puts 'Roles created successfully!'
  end
end


