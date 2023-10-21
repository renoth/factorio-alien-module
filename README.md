# factorio-alien-module
A mod for factorio [Link to mod portal](https://mods.factorio.com/mod/alien-module)

Biters now drop alien ore from which you can smelt alien plates that you can use in alien recipes.

## Building the mod
 
 With maven installed issue the following command:
 
 `mvn assembly:single install`
 
 The target folder should now contain the mod zip file. All zipfiles from the target-folder will get copied to the configured factorio mod folder.
 
 The factorio mod folder can be configured in
 
 `src/config.properties`
