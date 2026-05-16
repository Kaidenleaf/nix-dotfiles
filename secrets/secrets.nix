let 
  zenith-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVrN3kjibm/VkxVfCVGHvsdI0L1xdt3zRqK900rrqoH root@zenith";
  kaiden = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0RhhKWUO+HCv+8HLxp8HyVNOXUviM6EdZmGlfGE5ds kaiden@zenith";
in 
{
  "restic-password.age".publicKeys = [ zenith-host kaiden ];
  "restic-env.age".publicKeys      = [ zenith-host kaiden ];
}