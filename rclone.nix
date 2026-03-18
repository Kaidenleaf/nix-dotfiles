{ pkgs, config, ... }:

{
  systemd.services.rclone-filen = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "kaiden";
      
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/kaiden/Drive/Filen";
      
      ExecStart = ''
        /run/current-system/sw/bin/rclone mount filenremote: /home/kaiden/Drive/Filen \
          --config /home/kaiden/.config/rclone/rclone.conf \
          --vfs-cache-mode full \
          --vfs-cache-max-size 10G \
          --vfs-cache-max-age 24h \
          --allow-other \
          --uid 1000 \
          --gid 100 \
          --umask 022
      '';

      # Desmontaje limpio
      ExecStop = "/run/wrappers/bin/fusermount -u /home/kaiden/Drive/Filen";
      
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin:$PATH" ];
    };
  };

  # Backup local file to filen
  systemd.services.rclone-sync-backup = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "kaiden";
      ExecStart = "/run/current-system/sw/bin/rclone copy /home/kaiden/Documents/Omnisync filenremote:Omnisync --config /home/kaiden/.config/rclone/rclone.conf";
    };
  };

  systemd.timers.rclone-sync-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "15m";
      Unit = "rclone-sync-backup.service";
      Persistent = true;
    };
  };
}