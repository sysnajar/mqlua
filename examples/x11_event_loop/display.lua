local motif = require 'motif'
local zmq = require 'zmq'

local socket_name = ... or 'inproc://display'

local socket = zmq.socket(zmq.PULL)

if socket:bind(socket_name) == nil then
	print('gui socket bind failed')
end

window = MainWindow {
	label = Label {
		editable = False,
		cursorPositionVisible = False,
		labelString = ''
	}
}

function input()
	if socket:getsockopt(zmq.EVENTS) == zmq.POLLIN then
		msg, len = socket:msg_recv()
		window.label:SetValues('labelString', msg)
		socket:getsockopt(zmq.EVENTS)
		if msg == 'quit' then
			app:SetExitFlag()
		end
	end
end

local resources = {
        '*fontList: variable',
        '*renderTable: variable',
        '*renderTable.variable.fontName: DejaVu Sans Mono',
        '*renderTable.variable.fontSize: 24',
        '*renderTable.variable.fontType: FONT_IS_XFT',
}

SetLanguageProc(nil, nil, nil)
app, toplevel = Initialize("Display", resources)

local w, h = toplevel:Screen()
toplevel:SetValues(XmNwidth, 200, XmNheight, 48)

Realize(toplevel, window)

fd = socket:getsockopt(zmq.FD)
socket:msg_recv(zmq.DONTWAIT)
inp = app:AddInput(fd, input)

app:MainLoop()

window:UnmanageChild()
window:Destroy()
socket:close()
