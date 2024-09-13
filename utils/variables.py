import random
import os
import math

# Generate a random password 
rand_pass = random.sample(range(0, 20),8)
passw = ''.join(str(element) for element in rand_pass)

# Generate 4 random numbers from 0 to 10
rand_number = random.sample(range(0, 10),4)
numbers = ''.join(str(element) for element in rand_number)

boolean = ['true', 'false']