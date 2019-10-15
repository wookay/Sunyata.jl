using Test
using PyCall

np = pyimport("numpy")

output = [0x01, 0x02, 0x03, 0x04]
audio = np.frombuffer(output, np.int16)

@test [0x0201, 0x0403] == audio == reinterpret(Int16, output)
