A = ceil(rand(4) * 10)

b = ceil(rand(4, 1) * 10)

rank(A)

Aug = [A b]

rref(Aug)

a1temp = A(2, 1) / A(1, 1) * (Aug(1, :))

row2prime = Aug(2, :) - a1temp
Aug2 = [Aug(1, :); row2prime; Aug(3:4 , :)]

a2temp = A(3, 1) / A(1, 1) * (Aug(1, :))

row3prime = Aug(3, :) - a2temp

Aug3 = [Aug2(1:2, :); row3prime; Aug2(4, :)]

a3temp = A(4, 1) / A(1, 1) * Aug(1, :)
row4prime = Aug(4, :) - a3temp
Aug4 = [Aug3(1:3, :); row4prime]

a2primetemp = Aug4(3, 2) / Aug4(2, 2) * (Aug4(2, :))

row3prime2 = Aug4(3, :) - a2primetemp
Aug4 = [Aug4(1:2, :); row3prime2; Aug4(4, :)]

a2primetemp = Aug4(4, 2) / Aug4(2, 2) * Aug4(2, :)
row4prime2 = Aug4(4, :) - a2primetemp
Aug4 = [Aug4(1:3, :); row4prime2]

a3primetemp = Aug4(4, 3) / Aug4(3, 3) * Aug4(3, :)
row4prime3 = Aug4(4, :) - a3primetemp
Aug4 = [Aug4(1:3, :); row4prime3]  

x4 = Aug4(4, 5) / Aug4(4, 4)
A\b

x3 = (Aug4(3, 5) - Aug4(3, 4) * x4) / Aug4(3, 3)

x2 = (Aug4(2, 5) - Aug4(2, 3) * x3 - Aug4(2, 4) * x4) / Aug4(2, 2)

x1 = (Aug4(1, 5) - Aug(1, 2) * x2 - Aug(1, 3) * x3 - Aug(1, 4) * x4) / Aug4(1, 1)