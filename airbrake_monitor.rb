# frozen_string_literal: true

require 'json'
require 'csv'
require 'net/http'
require 'uri'
require 'active_support/all'

# CSV conversion method to convert the json to a CSV file and store in the current directory
def csv_conversion(data, file_name)
  CSV.open("#{file_name}", "w") do |csv|
    # Header
    csv << [
      "group_id", "projectId", "environment", "severity",
      "error_type", "error_message",
      "file", "function", "line",
      "noticeCount", "createdAt", "lastNoticeAt"
    ]

    data[:errors].each do |group|
      group_id = group["id"]
      project_id = group["projectId"]
      context = group["context"] || {}
      environment = context["environment"]
      severity = context["severity"]
      notice_count = group["noticeCount"]
      created_at = group["createdAt"]
      last_notice_at = group["lastNoticeAt"]

      (group["errors"] || []).each do |error|
        error_type = error["type"]
        error_message = error["message"]
        backtrace = error["backtrace"]&.first || {}

        csv << [
          group_id,
          project_id,
          environment,
          severity,
          error_type,
          error_message,
          backtrace["file"],
          backtrace["function"],
          backtrace["line"],
          notice_count,
          created_at,
          last_notice_at
        ]
      end
    end
  end
end

# API call to Airbrake

errors = []
data = { errors: [] }
['authorizenet', 'authorize.net'].each do |search_term|
  url = URI("https://airbrake.io/api/v4/projects/500916/groups?search=#{search_term}&order=last_notice")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true # use_ssl = true if HTTPS

  request = Net::HTTP::Get.new(url)
  request['Authorization'] = 'Bearer your_token_here' # Replace with your actual token
  request['Content-Type'] = 'application/json'

  response = http.request(request)
  data[:errors] += JSON.parse(response.body)['groups'] if response.code.to_i == 200
rescue StandardError => e
  errors << e.message
  puts "❌ Failed with error: #{errors.join(", ")}"
end

if data[:errors].present?
  file_name = "airbrake_flattened_errors_#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
  csv_conversion(data, file_name)
  puts "✅ CSV file '#{file_name}' created successfully."
else
  puts "No data found. #{errors.present? ? "Errors: #{errors.join(', ')}" : ''}"
end
