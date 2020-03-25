# Factorio-Player-Request-Crafting-Layout
A way for players to apply their crafting item layout to their logistics window.

A toolbar button is available for each player to apply the crafting layout to their logisitics tab. When clicked all of their current logistic request & trash values will be applied within the new layout, so no settings are lost. Any items not previousy being requested/trashed will have a default of requesting 0 and storing infinite applied.

This is a simple POC mod around an idea by Colonel Will, but is fully functional.


Testing The Mod
-------------

To test the mod you will need to have logisitics unlocked. The simpliest way to do this in a new map is to unlock the technology via command:
`/c game.player.force.technologies["logistic-robotics"].researched = true`