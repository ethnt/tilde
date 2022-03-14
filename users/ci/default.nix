{ hmUsers, ... }: { home-manager.users = { inherit (hmUsers) ci; }; }
