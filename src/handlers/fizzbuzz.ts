import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';

import { fizzbuzz_generator } from '../domain/fizzbuzz';

export const handler = async (event: APIGatewayEvent): Promise<APIGatewayProxyResult> => {
  const output = fizzbuzz_generator(3);

  console.log(`Event: ${JSON.stringify(event, null, 2)}`);
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: output,
    }),
  };
};
