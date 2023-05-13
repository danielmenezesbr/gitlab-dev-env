token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api', 'read_api', 'read_user', 'read_repository', 'write_repository', 'sudo'], name: 'Automation token');
token.set_token('mytoken');
token.save!;

user = User.find_by_username('root');
new_password = 'password123456@';
user.password = new_password;
user.password_confirmation = new_password;
user.save!

user = User.new(
  username: 'developer-a1', 
  password: 'password123456@', 
  password_confirmation: 'password123456@',
  skip_confirmation: true,
  email: 'developer-a1@my-organization.com',
  name: 'developer-a1')
user.save!

user = User.new(
  username: 'developer-a2', 
  password: 'password123456@', 
  password_confirmation: 'password123456@',
  skip_confirmation: true,
  email: 'developer-a2@my-organization.com',
  name: 'developer-a2')
user.save!

user = User.new(
  username: 'manager-a1', 
  password: 'password123456@', 
  password_confirmation: 'password123456@',
  skip_confirmation: true,
  email: 'manager-a1@my-organization.com',
  name: 'manager-a1')
user.save!

user = User.new(
  username: 'architect-a1', 
  password: 'password123456@', 
  password_confirmation: 'password123456@',
  skip_confirmation: true,
  email: 'architect-a1@my-organization.com',
  name: 'architect-a1')
user.save!


user = User.new(
  username: 'developer-b1', 
  password: 'password123456@', 
  password_confirmation: 'password123456@',
  skip_confirmation: true,
  email: 'developer-b1@my-organization.com',
  name: 'developer-b1')
user.save!

group = Group.new(name: 'my-organization', path: 'my-organization')
group.add_member(User.find_by(username: 'root'), GroupMember::OWNER)
group.save!

group = Group.new(name: 'my-departament', path: 'my-departament')
group.parent = Group.find_by(name: 'my-organization')
group.save!

group = Group.new(name: 'team-a', path: 'team-a')
group.parent = Group.find_by(name: 'my-departament')
group.add_member(User.find_by(username: 'manager-a1'), GroupMember::OWNER)
group.add_member(User.find_by(username: 'architect-a1'), GroupMember::MAINTAINER)
group.add_member(User.find_by(username: 'developer-a1'), GroupMember::DEVELOPER)
group.add_member(User.find_by(username: 'developer-a2'), GroupMember::DEVELOPER)
group.save!

group = Group.new(name: 'team-b', path: 'team-b')
group.parent = Group.find_by(name: 'my-departament')
group.add_member(User.find_by(username: 'developer-b1'), GroupMember::DEVELOPER)
group.save!


config = Gitlab::CurrentSettings.current_application_settings
config.allow_local_requests_from_hooks_and_services = true
config.default_auto_devops_pipeline_enabled = false
config.save!


=begin
namespace_name = "my-organization/my-departament/team-a"
project_name = "java_project_jenkins"
project = Project.find_by_path("#{namespace_name}/#{project_name}")

webhook = project.hooks.new(
  url: "http://jenkins:8080/project/MeuJobDePipeline",
  push_events: true,
  tag_push_events: true,
  enable_ssl_verification: false
)

webhook.save!
=end