{ pkgs, ...}:
{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    fonts = {
      sizes.desktop = 12;
      sansSerif = {
        package = pkgs.texlivePackages.nunito;
        name = "Nunito";
      };
    };
  };
}