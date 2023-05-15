project = Project.find_by_full_path('my-organization/my-departament/team-a/java_project_jenkins')

webhook = project.hooks.new(
  url: "http://jenkins:8080/project/MeuJobDePipeline",
  push_events: true,
  tag_push_events: true,
  merge_requests_events: true,
  enable_ssl_verification: false
)

webhook.save!

=begin
curl --request PUT --header "PRIVATE-TOKEN: token-string-here321" \
     --url 'http://localhost:8080/api/v4/projects/3' \
     --data "only_allow_merge_if_pipeline_succeeds=true"
=end

require 'net/http'
require 'json'

gitlab_url = 'http://web'
private_token = 'token-string-here321'
project_id = '3'

merge_request_settings = {
  only_allow_merge_if_pipeline_succeeds: true
}

settings_json = merge_request_settings.to_json

api_url = "#{gitlab_url}/api/v4/projects/#{project_id}"

uri = URI(api_url)
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Put.new(uri.path)
request['PRIVATE-TOKEN'] = private_token
request['Content-Type'] = 'application/json'
request.body = settings_json

response = http.request(request)
puts response.code