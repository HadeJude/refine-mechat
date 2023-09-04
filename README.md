# refine-mechat
 A clean Standalone chat that I have a long time ago and optimize it with Unique 3dme on it


## Need Unique Script Experience?
- [Tebex](https://refined.tebex.io/)

## Need Assistance?
- [Discord](https://discord.gg/Va9YArM6uW)


### Features
 * Customizable Color, Position & Styles
 * Clean Chat and Fade Effect in chat
 * Can use with our without "/"
 * Any Resolution Support
 * 3dme Support Standalone with Name on it
 * Alot of ME function
 * Standalone
 * Whitelist Calls With Reply Method

---
- [Demos](#demos)
- [Installation](#installation)
- [Usage](#usage)
---

## Demos
- [Video](https://youtu.be/_rAG2L8aRf0)

---

## Installation
* Delete `chat` directory in `resources\[cfx-default]\[gameplay]\chat`
* Drop the `refine-mechat` directory into you `resources` directory
* Add `ensure refine-mechat` to your `server.cfg` file
* For QB-Core go to `qb-core>server>commands.lua` and look for command line `QBCore.Commands.Add('me'` and delete it.

---

## Usage
This is the usage and example that you can do:
```lua
    -- in this example it will show what's poppin on chat
    RegisterCommand('testfont', function(source, args)
        --this is how you can add custom chat
        TriggerEvent("chat:addMessage", {
            template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(180, 117, 22, 0.750); border: 2px solid rgb(180, 117, 22);"><i class="far fa-building"style="font-size:15px"></i> | {0} </font></i></b></div>',
            args = {"This is just a Test"}
        })
        --this is the list that you can add in chat <3
        TriggerEvent("chatMessage", "Testing", "advert", "Test")
        TriggerEvent("chatMessage", "Testing", "warning", "Test")
        TriggerEvent("chatMessage", "Testing", "normal", "Test")
        TriggerEvent("chatMessage", "Testing", "error", "Test")
        TriggerEvent("chatMessage", "Testing", "system", "Test")
        TriggerEvent("chatMessage", "Testing", "emergency", "Test")
        TriggerEvent("chatMessage", "Testing", "nonemergency", "Test")
        TriggerEvent("chatMessage", "Testing", "report", "Test")
        TriggerEvent("chatMessage", "police", "report", "Test")
        TriggerEvent("chatMessage", "ems", "report", "Test")
    end, false)

    --if you want to add suggest in "standalone" mode you can use look for this example and add something on the line

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        TriggerEvent('chat:addSuggestion', '/me', 'Show local message', {{ name="message"}})
        TriggerEvent('chat:addSuggestion', '/mea', 'Show local message anonymous.', {{ name="message"}})
        TriggerEvent('chat:addSuggestion', '/mename', 'Change your Anonymous Name', {{ name="NAME"}})
        --this one is example
        TriggerEvent('chat:addSuggestion', '/thisisexample', 'change me here', {{ name="NAME"}})
    end)
    -- sometimes the 911 or 311 didn't work because you already have it on your dispatch so I provide some Event that you can put on or just disable your old 911 or 311 call

    --Client Side
    TriggerServerEvent('refine-mechat:dispatch:police', msg)
    TriggerServerEvent('refine-mechat:dispatch:ambulance', msg)
    TriggerServerEvent('refine-mechat:anon:police', msg)
    TriggerServerEvent('refine-mechat:anon:ambulance', msg)

    --Server Side
    TriggerEvent('refine-mechat:dispatch:police', msg)
    TriggerEvent('refine-mechat:dispatch:ambulance', msg)
    TriggerEvent('refine-mechat:anon:police', msg)
    TriggerEvent('refine-mechat:anon:ambulance', msg)

```
