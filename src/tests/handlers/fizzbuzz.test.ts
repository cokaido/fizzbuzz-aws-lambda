// Import dynamodb from aws-sdk

import { handler } from '../../handlers/fizzbuzz';
import { constructAPIGwEvent } from '../factories/handler-event-factory';

// This includes all tests for getAllItemsHandler()
describe('Test fizzbuzz lambda', () => {


  it('should return Fizz when called with 3', async () => {

    // Return the specified value whenever the spied scan function is called
   

    const event = constructAPIGwEvent({}, { method: 'GET' });

    const result = await handler(event);

    const expectedResult = {
      statusCode: 200,
      body: JSON.stringify({'message':'Fizz'}),
    };

    // Compare the result with the expected result
    expect(result).toEqual(expectedResult);
  });
});
