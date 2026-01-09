{ config, pkgs, ... }:

{
  fileSystems."/home/kaiden/datos" = {
    device = "/dev/disk/by-uuid/fab5fde2-a0ab-4121-9d55-be3daf827020";
    fsType = "ext4"; # O ntfs-3g, exfat, etc.
    options = [ "defaults" "user" "rw" "nofail" "noatime" ];
  };
  
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/9f5c2095-be00-43c9-be07-5b6faf5bc91b";
    fsType = "ext4"; # O ntfs-3g, exfat, etc.
    options = [ "defaults" "user" "rw" "nofail" "noatime" ];
  };

}
