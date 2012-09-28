people = People.create :birthdate => '1900-01-01', :gender => 'Male', 
  :creator => 1, :voided => 0

PeopleNames.create :people_id => people.id , :first_name => 'Admin', :last_name => 'Admin',
  :creator => 1, :voided => 0

user = Users.create :username => 'admin', :password_hash => 'admin', :people_id => people.id,
  :creator => 1, :voided => 0 

PeopleAttributeTypes.create :name => 'Student' , :description => 'Registered student',
  :creator => 1, :voided => 0

PeopleAttributeTypes.create :name => 'Staff' , :description => 'Registered staff member',
  :creator => 1, :voided => 0

PeopleAttributeTypes.create :name => 'Email' , :description => "Person's email address",
  :creator => 1, :voided => 0


UserRoles.create :user_id => user.id, :role => 'admin'
puts "Your new user is: admin, password: admin"


