project = Project.find_by_full_path('my-organization/my-departament/team-a/java_project_jenkins')

webhook = project.hooks.new(
  url: "http://jenkins/project/MeuJobDePipeline",
  push_events: true,
  tag_push_events: true,
  merge_requests_events: true,
  enable_ssl_verification: false
)

webhook.save!