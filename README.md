# org.TheWorldMachine.GTKNoCSD
Unofficial repo for flatpak manifest for org.TheWorldMachine.GTKNoCSD

# Build Instructions
1. Clone the repo
2. If building for gnome platform versions other than 48 or 49 
- Duplicate the yml file and rename the file as
`org.TheWorldMachine.GTKNoCSD-${version}.yml`
- Replace ${version} with actual version name for eg:47 so that the filename is `org.TheWorldMachine.GTKNoCSD-47.yml`
- Edit the new file and replace `runtime-version: "48"` line with your desired version for eg: `runtime-version: "47"`
2. Run build.sh
3. The library is built on `./org.gnome.Platform/${version}/libgtk-nocsd.so`

# Usage
1. see which applications use which runtime with this command  
`flatpak list --app --columns=application,runtime | grep org.gnome.Platform/x86_64/${version}`  
replace version with the version of org.gnome.Platform or org.gnome.Sdk for eg: 48 or 49 (as used in this repo) or your own version  
2.
- Either Use flatseal to give the permissions to each of the apps from the list:
```
filesystems: /the/path/to/the/built/library/with/correct/version/of/the/platform
environment: LD_PRELOAD=/full/path/to/the/library/with/correct/version/of/the/platform
```
- Or if you dont use flatseal then use these commands replacing the contents as necessary
```
flatpak override --filesystem=/the/path/to/the/built/library/with/correct/version/of/the/platform --env=LD_PRELOAD=/full/path/to/the/library/with/correct/version/of/the/platform ${appname}
```
- Replace the `filesystem` and `env` path as real path to the library. For example: 
```
flatpak override --filesystem=/home/user/.local/lib --env=/home/user/.local/lib/org.gnome.Platform/49/libgtk-nocsd.so org.application.name
```
- If you are using `--user` flag for installing the flatpak applications (ie. your flatpak apps install in ~/.local/share/flatpak) then you can use the `--user` flag in the flatpak override command.
- For example 
```
flatpak override --filesystem=/home/user/.local/lib --env=/home/user/.local/lib/org.gnome.Platform/49/libgtk-nocsd.so org.application.name --user
```
