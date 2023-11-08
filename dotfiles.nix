{ config, inputs, lib, ... }:
let

  generateFiles = files: (map
    (f: {
      name = "${f}";
      value = {
        source = ./. + "/${f}";
      };
    })
    files
  );

  generateDirectoriesRecursive = directories: (map
    (d: {
      name = "${d}";
      value = {
        source = ./. + "/${d}";
        recursive = true;
      };
    })
    directories
  );

  filterFileType = type: file:
    (lib.filterAttrs (name: type': type == type') file);

  filterExcludeExtension = extension: file:
    (lib.filterAttrs (name: value: !(lib.hasSuffix extension name)) file);

  filterRegularFiles = filterFileType "regular";

  filterDirectories = filterFileType "directory";

  myFiles = lib.attrNames (filterExcludeExtension ".lock" (filterExcludeExtension ".nix" (filterRegularFiles (builtins.readDir ./.))));
  myDirectories = lib.attrNames (filterDirectories (builtins.readDir ./.));
in
{
  config = {
    systemd.user.startServices = true;
    home.file = builtins.listToAttrs ((generateFiles myFiles) ++ (generateDirectoriesRecursive myDirectories));
  };
}
