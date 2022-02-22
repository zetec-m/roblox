# roblox
Some stuff for roboloxus


### Request.lua Example Usage:
```lua
sendRequest("http://httpbin.org/get", "GET", function(response)
    warn("---------[ Response ]---------")
    print(response)
    warn("------------------------")
end)
```
