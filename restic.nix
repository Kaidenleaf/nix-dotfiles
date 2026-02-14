{ config, pkgs, ... }:

{
  services.restic.backups = {
    remoteBackup = {
      # Configuración del repositorio
      repository = "s3:s3.us-east-005.backblazeb2.com/backups-kn";
      passwordFile = "/home/kaiden/Documents/restic-password";
      environmentFile = "/home/kaiden/Documents/restic-env";

      paths = [
        "/home/kaiden/datos/other"
      ];

      timerConfig = {
        OnCalendar = "00:00";
        Persistent = true;
      };

      # Estrategia de retención (Limpieza automática)
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
    };
  };
}
