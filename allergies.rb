require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)


def header
  system('clear')
  puts "*" * 88
  puts "\t\t\tDINNER PARTY DIETARY RESTRICTIONS TRACKER"
  puts "*" * 88
end

def main_menu
  header
  puts "1) View/add Guests"
  puts "2) Add/edit Allergies"
  puts "3) Add/edit Preferences"
  puts "4) Run Reports"
  puts "5) Exit"
  puts "Enter a selection"
  case gets.chomp.to_i
  when 1
    guests_menu
  when 2
    allergies_menu
  when 3
    preferences_menu
  when 4
    reports_menu
  when 5
    exit
  else
    puts "Enter a valid option"
  end
  main_menu
end

def preferences_menu
  header
  view_preferences
  puts "Enter 'n' to add a new preference"
  puts "Enter the preference number to edit an existing preference"
  puts "Enter 'm' to return to the main menu"
  input = gets.chomp
  if input == 'n'
    new_preference
  elsif input == 'm'
    main_menu
  else
    preference = Preference.find(input.to_i)
    edit_remove_preference(preference)
  end
  preferences_menu
end

def edit_remove_preference(preference)
  puts "1) Edit preference"
  puts "2) Delete preference"
  puts "3) Return to the preferences menu"
  case gets.chomp.to_i
  when 1 then edit_preference(preference)
  when 2 then preference.destroy
  when 3 then preferences_menu
  else
    puts "Enter a valid option"
  end
  preferences_menu
end

def new_preference
  puts "Enter the new preference"
  preference = Preference.new(name: gets.chomp.upcase)
  validate_new(preference)
end

def validate_new(new_object)
  if new_object.save
    puts "#{new_object.class} created!"
  else
    puts "That wasn't a valid entry:"
    new_object.errors.full_messages.each {|message| puts message}
  end
end

def view_preferences
  puts "PREFERENCES:"
  Preference.all.each do |preference|
    puts preference.id.to_s + ") " + preference.name.to_s
  end
end

def edit_preference(preference)
  puts "Enter the new preference name"
  if preference.update(name: gets.chomp.upcase)
  else
    puts "That wasn't a valid entry:"
    preference.errors.full_messages.each {|message| puts message}
    puts "Try again? y/n"
    case gets.chomp.downcase
    when 'y' then edit_preference(preference)
    when 'n' then preferences_menu
    end
  end
end

def allergies_menu
  header
  view_allergies
  puts "Enter 'n' to add a new allergy"
  puts "Enter the allergy number to edit an existing allergy"
  puts "Enter 'm' to return to the main menu"
  input = gets.chomp
  if input == 'n'
    new_allergy
  elsif input == 'm'
    main_menu
  else
    allergy = Allergy.find(input.to_i)
    edit_remove_allergies(allergy)
  end
  allergies_menu
end

def edit_remove_allergies(allergy)
  puts "1) Edit allergy"
  puts "2) Delete allergy"
  puts "3) Return to the allergies menu"
  case gets.chomp.to_i
  when 1 then edit_allergy(allergy)
  when 2 then allergy.destroy
  when 3 then allergies_menu
  else
    puts "Enter a valid option"
  end
  allergies_menu
end

def new_allergy
  puts "Enter the new allergy"
  allergy = Allergy.new(name: gets.chomp)
  validate_new(allergy)
end

def edit_allergy(allergy)
  puts "Enter the new allergy name"
  if allergy.update(name: gets.chomp.upcase)
  else
    puts "That wasn't a valid entry:"
    allergy.errors.full_messages.each {|message| puts message}
    puts "Try again? y/n"
    case gets.chomp.downcase
    when 'y' then edit_allergy(allergy)
    when 'n' then allergies_menu
    end
  end
end

def view_allergies
  puts "ALLERGIES:"
  Allergy.all.each do |allergy|
    puts allergy.id.to_s + ") " + allergy.name.to_s
  end
end

def guests_menu
  header
  puts "1) Add a new guest"
  puts "2) Search for a guest to view, edit, or remove"
  puts "3) Display list of all guests"
  puts "4) Return to main menu"
  case gets.chomp.to_i
  when 1
    add_guest
  when 2
    search_guest
  when 3
    view_guests
  when 4
    main_menu
  else
    puts "Enter a valid option"
  end
  guests_menu
end

def view_guest(guest)
  puts "NAME: " + guest.name
  puts "PREFERENCE: " + guest.preference
  puts "ALLERGIES:"
  guest.allergies.each do |allergy|
    puts "\t" + allergy.name
  end
end

def search_guest
  puts "Enter the name of the guest"
  guest = Person.find(gets.chomp.upcase)
  guest_menu(guest)
end

def guest_menu(guest)
  view_guest(guest)
  puts "1) Edit guest's name"
  puts "2) Edit guest's preference"
  puts "3) Edit guest's allergies"
  puts "4) Remove guest"
  puts "5) Return to guests menu"
  case gets.chomp.to_i
  when 1
    puts "Enter the new name"
    guest.edit_name(gets.chomp.upcase)
  when 2
    view_preferences
    puts "Enter new preference number"
    guest.edit_preference(gets.chomp.to_i)
  when 3
    add_remove_allergies(guest)
  when 4
    guest.delete
    guests_menu
  when 5
    guests_menu
  else
    puts "Enter a valid option"
  end
  guest_menu(guest)
end

def add_remove_allergies(guest)
  puts "1) Add an allergy"
  puts "2) Remove an allergy"
  puts "3) Return to guest menu"
  case gets.chomp.to_i
  when 1
    view_allergies
    puts "Enter new allergy number"
    guest.add_allergy(gets.chomp.to_i)
  when 2
    view_allergies
    puts "Enter the allergy number to remove"
    guest.remove_allergy(gets.chomp.to_i)
  when 3
    guest_menu
  else
    puts "Enter a valid option"
  end
  guest_menu(guest)
end

def add_guest
  header
  puts "Enter the name of the guest"
  name = gets.chomp.upcase
  view_preferences
  puts "Enter the preference number or 'n' to create a new preference"
  preference_input = gets.chomp
  if preference_input == 'n'
    new_preference
    add_guest
  else
    view_allergies
    puts "Enter the allergy number or 'n' to create a new allergy"
    allergy_input = gets.chomp
    if allergy_input == 'n'
      new_allergy
      add_guest
    else
      new_person = Person.new({'name' => name, 'preference_id' => preference_input.to_i})
      new_person.save
      new_person.add_allergy(allergy_input.to_i)
    end
  end
end

def view_guests
  header
  puts "GUESTS:"
  Person.all.each do |person|
    puts person.name
  end
  puts "1) Return to guests menu"
  puts "2) Return to main menu"
  case gets.chomp.to_i
  when 1
    guests_menu
  when 2
    main_menu
  else
    puts "Enter a valid option"
  end
end

def reports_menu
  header
  summary
  puts "1) View counts of each preference"
  puts "2) View allergies by preference"
  puts "3) View guests with a particular preference"
  puts "4) View guests with a particular allergy"
  puts "5) Return to main menu"
  case gets.chomp.to_i
  when 1
    Preference.all.each do |preference|
      puts preference.name + " - " + preference.count.to_s
    end
  when 2
    Preference.all.each do |preference|
      print preference.name + " - "
      names = preference.allergies.map { |allergy| allergy.name }
      puts names.uniq.join(", ")
    end
  when 3
    view_preferences
    puts "Enter the preference number"
    results = Person.search_by_preference(gets.chomp.to_i)
    results.each do |person|
      puts person.name
      print "ALLERGIES:"
      person.allergies.each do |allergy|
        print " " + allergy.name
      end
      puts
    end
    puts
  when 4
    view_allergies
    puts "Enter the allergy number"
    results = Person.search_by_allergy(gets.chomp.to_i)
    results.each do |person|
      puts person.name
      print "PREFERENCE: " + person.preference + "\n"
    end
    puts
  when 5
    main_menu
  else
    puts "Enter a valid option"
  end
  puts "Hit enter to return to the reports menu"
  gets.chomp
  reports_menu
end

def summary
  puts "GUESTS: " + Person.all.length.to_s
  print "ALLERGENS:"
  Allergy.all.each do |allergy|
    print " " + allergy.name
  end
  print "\nPREFERENCES:"
  Preference.all.each do |preference|
    print " " + preference.name
  end
  puts
end

header
main_menu
