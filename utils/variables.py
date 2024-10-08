import random
import os
import math

rand_pass = random.sample(range(0, 20),8)
passw = ''.join(str(element) for element in rand_pass)

rand_number = random.sample(range(0, 10),4)
numbers = ''.join(str(element) for element in rand_number)

rand_number_one = random.sample(range(10, 100),1)

invalid_id = '1MQzGyfDuuGga27b'