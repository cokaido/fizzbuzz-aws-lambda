import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';

import { fizzbuzz_generator } from '../domain/fizzbuzz';

export const handler = async (event: APIGatewayEvent): Promise<APIGatewayProxyResult> => {
  if (!event.body) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: 'Number parameter missing',
      }),
    };
  }

  const number = parseInt(JSON.parse(event.body).number);

  const output = fizzbuzz_generator(number);

  console.log(`Event: ${JSON.stringify(event, null, 2)}`);

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: output,
    }),
  };
};
