local frameDataURL = "http://127.0.0.1:8182/1/frame.txt"

function split(inputString, separateWith)
    if separateWith == nil then
        separateWith = ", "
    end
    local t={}
    for str in string.gmatch(inputString, "([^"..separateWith.."]+)") do
        table.insert(t, str)
    end
    return t
end

function repeatString(inputString, times)
  if times == nil then
    times = 1
  end
  local t = ""
  for i = 1, times do
      t = t..inputString
  end
  return t
end

local m = peripheral.wrap("right")
m.setTextScale(0.5)
print(m.getSize())

local lastData = ""

while true do
    local infoReq = nil 
    infoReq = http.get(frameDataURL)
    if infoReq ~= nil then
        local data = infoReq.readAll()
        infoReq.close()

        if lastData ~= data then
            lastData = data
            local lines = split(data,"\n")

            m.setTextScale(0.5)
            m.setCursorPos(1, 1)
            m.clear()

            for lineIndex=1,#lines do
                local line = lines[lineIndex]
                m.setCursorPos(1, lineIndex)
                m.blit(repeatString(" ", #line), repeatString("f", #line), line)
            end
        end
    end
    sleep(1/30)
end
