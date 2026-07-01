{
  config.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      presets = {
        #   marksman.enable = true;
        # markdown-oxide.enable = true;
      };
      servers = {
        markdown-oxide = {
          enable = true;
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true;
              };
            };
          };
        };
      };
    };
  };
}
