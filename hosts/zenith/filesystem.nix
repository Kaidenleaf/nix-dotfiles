{ config, pkgs, ... }:

{
  fileSystems."/home/kaiden/datos" = {
    device = "/dev/disk/by-uuid/fab5fde2-a0ab-4121-9d55-be3daf827020";
    fsType = "ext4"; # O ntfs-3g, exfat, etc.
    options = [ "defaults" "user" "rw" "nofail" "noatime" ];
  };
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/897474d7-ac6e-4ae6-bcac-1465d8842e3a";
    fsType = "ext4";
    options = ["users" "rw" "nofail" "noatime" ];
  };
}
