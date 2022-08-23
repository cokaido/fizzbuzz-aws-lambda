import {fizzbuzz_generator} from '../../domain/fizzbuzz';

describe('Test fizzbuzz domain object', () => {


  it('should return Fizz when called with 3', async () => {

    // Return the specified value whenever the spied scan function is called
    const result =  fizzbuzz_generator(3);
    const expectedResult = 'Fizz';

    // Compare the result with the expected result
    expect(result).toEqual(expectedResult);
  });
});
