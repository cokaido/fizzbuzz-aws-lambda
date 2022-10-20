import { fizzBuzz } from '../../domain/fizzbuzz';

describe('FizzBuzz', () => {
  test.each([
    [1, '1'],
    [2, '2'],
    [4, '4'],
    [7, '7'],
  ])('of %s should be %s', (input: number, expectedValue: string) => {
    expect(fizzBuzz(input)).toBe(expectedValue);
  });

  test.each([[3], [6], [9]])(
    'of multiples of 3 (example %s) should be "Fizz"',
    (input: number, expectedValue = 'Fizz') => {
      expect(fizzBuzz(input)).toBe(expectedValue);
    }
  );

  test.each([[5], [10], [20]])(
    'of multiples of 5 (example %s) should be "Buzz"',
    (input: number, expectedValue = 'Buzz') => {
      expect(fizzBuzz(input)).toBe(expectedValue);
    }
  );

  test.each([[15], [30], [45]])(
    'of multiples of both 3 and 5 (for example %s) should be "FizzBuzz"',
    (input: number, expectedValue = 'FizzBuzz') => {
      expect(fizzBuzz(input)).toBe(expectedValue);
    }
  );
});
