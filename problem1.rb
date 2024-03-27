require 'httparty'
require 'json'

username = "TheKelso91"
url = "https://api.github.com/users/#{username}/repos"

response = HTTParty.get(url)

if response.code == 200
  repos = JSON.parse(response.body)

  most_starred_repo = repos.max_by { |repo| repo["stargazers_count"] }

  puts "Most Starred Repository for #{username}:"
  puts "Name: #{most_starred_repo['name']}"
  puts "Description: #{most_starred_repo['description']}"
  puts "Stars: #{most_starred_repo['stargazers_count']}"
  puts "URL: #{most_starred_repo['html_url']}"
else
  puts "Error fetching repository data. Response code: #{response.code}"
end
