local node = require 'node'

for k, v in pairs(arg) do
	print(v)
end

node.create('node_01.lua')

node.create('gui.lua', 'inproc://gui')
node.create('pos.lua', 'inproc://gui')
