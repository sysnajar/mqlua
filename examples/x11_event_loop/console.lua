-- Text console sending input to a graphical display

local zmq = require 'zmq'

local socket = zmq.socket(zmq.PUSH)

local socket_name = ... or 'inproc://display'

if socket:connect(socket_name) == nil then
	return error('socket connect failed')
end

local input = ''

print('Enter quit to terminate')

while input ~= 'quit' do
	io.write('console > ')
	input = io.read()

	if socket:send(input) == nil then
		print('error sending text to display')
	end
end

socket:close()
