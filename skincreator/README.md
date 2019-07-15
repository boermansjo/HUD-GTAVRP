# Character Creator

**Do not use these scripts if you are not comfortable with development.**
**If you have some issues with code, ask the community on the official [FiveM's topic](https://forum.fivem.net/t/preview-enhanced-hud/634217).**

## How to install

* Import ```outfits.sql``` to your database
* Include [this code](#code) somewhere you init first player connection
* Copy and paste ```skincreator``` folder to ```resources```
* Add ```start skincreator``` to your ```server.cfg``` file

## Code

This function will add user to the outfits SQL's table. This code must be included somewhere you init player (something like isFirstConnection function). It's server-side function.
```
MySQL.Async.execute("INSERT INTO outfits (idSteam) VALUES ('[SteamID of user or anything ID you use to identify unique player]')")
```

## Files

* ```ui/script.js``` JS for NUI elements
* ```ui/front.js``` JS for HTML interaction
* ```ui/styles.scss``` use this to edit CSS if you are comfortable with CSS pre-processor (must be compiled)

## Credits & licence

Nicolas Marx (alias [Naiko](https://twitter.com/naikzer_)) is the only owner of these scripts. You are free to use and edit the source code as you want for personal or commercial use. 

## Other UIs

* [Character Creator](../skincreator)
* [Menu](../menu)
* [Speedometer](../speedometer) 
* [Inventory]() 
* [Messaging service]() 
* [Hunger/Thirst](../hungerthirst) 

## Dependencies

* [ESX](https://github.com/FXServer-ESX/fxserver-es_extended)
