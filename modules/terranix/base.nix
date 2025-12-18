{
  config,
  pkgs,
  lib,
  ...
}:

let
  getClanSecret = import ../../pkgs/get-clan-secret { inherit pkgs; };
in
{
  variable.passphrase = { };

  terraform.required_providers.external.source = "hashicorp/external";
  terraform.required_providers.hcloud.source = "hetznercloud/hcloud";
  terraform.required_providers.vultr.source = "vultr/vultr";

  data.external.hcloud-token = {
    program = [ (lib.getExe (getClanSecret "hcloud-token")) ];
  };

  data.external.vultr-api-key = {
    program = [ (lib.getExe (getClanSecret "vultr-api-key")) ];
  };

  provider.hcloud.token = config.data.external.hcloud-token "result.secret";
  provider.vultr.api_key = config.data.external.vultr-api-key "result.secret";
}
