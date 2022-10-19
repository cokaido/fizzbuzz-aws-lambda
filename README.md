# FizzBuzz

Solve the FizzBuzz problem

Write a program that prints the numbers from 1 to 100. But for multiples of three print “Fizz” instead of the number and for the multiples of five print “Buzz”. For numbers which are multiples of both three and five print “FizzBuzz”.

This program will be :

- Hosted on an AWS lambda
- Published through an API Gateway
- Deployed using Terraform

The scaffolding project uses husky

Intructions

- Configure husky hook :
- Run npm install to install all the dependencies
- Run /deploy.sh to deploy

---- How to call lambda after deployment ---
from console :
curl -X POST https://fizzbuzz.example.es/fizzbuzz -d '{"number": "3"}'

Or use RapidAPI extension or postman
