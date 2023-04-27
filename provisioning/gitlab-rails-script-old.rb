#it's doesn't work (create project, but don't start import). workaround: import project with ansible
"""
project = Project.new(
    name: 'java_project',
    path: 'java_project',
    namespace: Group.find_by(name: 'team-a'),
    import_url: 'https://github.com/danielmenezesbr/helloworld.git',
    creator: User.find_by(username: 'root')
)
project.save!
project.import_start

event = Event.new(
    project_id: project.id,
    action: 'import_start',
    author_id: User.find_by(username: 'root').id
)
project.add_event(event)

project = Project.find_by(name: 'java_project')
project.import_data.start!
project.import_start
"""