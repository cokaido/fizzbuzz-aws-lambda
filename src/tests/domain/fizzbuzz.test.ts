import { fizzbuzz_generator } from '../../domain/fizzbuzz';

describe('Test fizzbuzz domain object', () => {
  it('should return Fizz when called with 3', async () => {

    const result = fizzbuzz_generator(3);
    const expectedResult = 'Fizz';

    expect(result).toEqual(expectedResult);
  });
});
