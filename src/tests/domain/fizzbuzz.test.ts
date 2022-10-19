import { fizzBuzz } from '../../domain/fizzbuzz';

describe('FizzBuzz', () => {
  test.each([
    [1, '1'],
    [2, '2'],
    [4, '4'],
    [7, '7'],
  ])('Fizzbuzz of %s should be "%s"', (input: number, expectedValue: string) => {
    expect(fizzBuzz(input)).toBe(expectedValue);
  });

  test.each([
    [3, 'Fizz'],
    [6, 'Fizz'],
    [9, 'Fizz'],
  ])('multiples of 3 should be "%s"', (input: number, expectedValue: string) => {
    expect(fizzBuzz(input)).toBe(expectedValue);
  });

  test.each([
    [5, 'Buzz'],
    [10, 'Buzz'],
    [20, 'Buzz'],
  ])('multiples of 5 should be "%s"', (input: number, expectedValue: string) => {
    expect(fizzBuzz(input)).toBe(expectedValue);
  });

  test.each([
    [15, 'FizzBuzz'],
    [30, 'FizzBuzz'],
    [45, 'FizzBuzz'],
  ])('multiples of both 3 and 5 should be "%s"', (input: number, expectedValue: string) => {
    expect(fizzBuzz(input)).toBe(expectedValue);
  });
});
