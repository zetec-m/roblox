local request = request or http_request or syn and syn.request or false
local bobloux = {}

if not request or request == false then
    game:GetService("Players").LocalPlayer:Kick("Sorry, but your exploit isn't supported.")
end

function bobloux(url, method, response)
    local ResponseCode, _Response = pcall(request, {
        Url = tostring(url),
        Method = tostring(method)
    })

    if type(_Response) == "table" then
        table.foreach(_Response, function(i, v)
            if i == "Body" then
                if string.len(v) < 1 then
                    response("[!] Something went wrong.")
                else
                    response(tostring(v))
                end
            end
        end)
    end
end

return bobloux
