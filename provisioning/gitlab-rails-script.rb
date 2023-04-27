token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api', 'read_api', 'read_user', 'read_repository', 'write_repository', 'sudo'], name: 'Automation token');
token.set_token('mytoken');
token.save!;

user = User.find_by_username('root');
new_password = 'password123456@';
user.password = new_password;
user.password_confirmation = new_password;
user.save!