# User configuration module
{ flake, lib, ... }:
{
  options = {
    me = {
      username = lib.mkOption {
        type = lib.types.str;
        description = "Your username as shown by `id -un`";
      };
      fullname = lib.mkOption {
        type = lib.types.str;
        description = "Your full name for use in Git config";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Your email for use in Git config";
      };
    };
    theme = lib.mkOption {
      default = "ansi";
      type = lib.types.str;
      description = "catppuccin or ansi";
    };
  };

  config = {
    # this is so bad but i can't be bothered to fix it
    me = {
      username = "tony";
      fullname = "Tony Du";
      email = "tonydu121@hotmail.com";
    };
    home.username = flake.config.me.username;
  };
}
