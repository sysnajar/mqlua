local node = require 'node'
local zmq = require 'zmq'

print('node ' .. node._COPYRIGHT)
print(node._DESCRIPTION .. ' version info: ' .. node._VERSION)

print('\nzmq ' .. zmq._COPYRIGHT)
print(zmq._DESCRIPTION .. ' version info: ' .. zmq._VERSION)

local major, minor, patch = zmq.version()
print('\n(0MQ version ' .. major .. '.' .. minor .. '.' .. patch ..')')

