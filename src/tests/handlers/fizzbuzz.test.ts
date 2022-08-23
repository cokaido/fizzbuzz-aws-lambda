
import { handler } from '../../handlers/fizzbuzz';
import { constructAPIGwEvent } from '../factories/handler-event-factory';

describe('Test fizzbuzz lambda', () => {
  it('should return Fizz when called with 3', async () => {

    const event = constructAPIGwEvent({}, { method: 'GET' });

    const result = await handler(event);

    const expectedResult = {
      statusCode: 200,
      body: JSON.stringify({ message: 'Fizz' }),
    };

    // Compare the result with the expected result
    expect(result).toEqual(expectedResult);
  });
});
