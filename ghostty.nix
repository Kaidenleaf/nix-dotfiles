{
  lib,
  ...
}: let
  configFile = "ghostty/config2";
in { 
  xdg.configFile."${configFile}" = {
    text = ''
    ${lib.generators.toKeyValue {
        mkKeyValue = k: v: "${k}=${v}";
        listsAsDuplicateKeys = true;
      } {
        theme = "TokyoNight Night";
        font-family = "Maple Mono NF";
        font-size = "10";
        background-opacity = "0.9";
        window-padding-x = "10";
        window-padding-y = "10";
        window-decoration = "none";
      }}
  '';
  mutable = true;
  };
}
