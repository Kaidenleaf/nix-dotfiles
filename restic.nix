{ config, pkgs, ... }:

{
  age.secrets.restic-password.file = ./secrets/restic-password.age;
  age.secrets.restic-env.file      = ./secrets/restic-env.age;

  services.restic.backups = {
    remoteBackup = {
      # Configuración del repositorio
      passwordFile = config.age.secrets.restic-password.path;
      environmentFile = config.age.secrets.restic-env.path;

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
