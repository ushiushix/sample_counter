require 'json'
require 'aws-sdk-dynamodb'

def get_incremented_value
  dynamodb = Aws::DynamoDB::Client.new(region: ENV['AWS_REGION'])
  str = Time.now.strftime('%Y-%m-%d')
  res = dynamodb.update_item(
      table_name: ENV['COUNTER_TABLE_NAME'],
      key: { 'pkey' => str },
      update_expression: 'ADD CallCount :incr',
      expression_attribute_values: {
        ':incr' => 1
      },
      return_values: 'ALL_NEW',
  )
  res.attributes
end

def lambda_handler(event:, context:)
  value = get_incremented_value
 body = <<~BODY
    <!DOCTYPE html>
    <html>
    <head>
    <title>Counter</title>
    </head>
    <body>
    <h1>#{value['CallCount'].to_i}</h1>
    </body>
    </html>
  BODY
  { statusCode: 200,
    headers: {
      'Content-Type' => 'text/html; charset=UTF-8',
    },
    body: body }
end
