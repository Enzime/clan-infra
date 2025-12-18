{ pkgs }:
secretName:
pkgs.writeShellApplication {
  name = "get-clan-secret";
  text = ''
    jq -n --arg secret "$(clan secrets get ${secretName})" '{"secret":$secret}'
  '';
}
