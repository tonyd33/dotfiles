{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      clojure = [ "clj-kondo" ];
      dockerfile = [ "hadolint" ];
      inko = [ "inko" ];
      janet = [ "janet" ];
      json = [ "jsonlint" ];
      markdown = [ "vale" ];
      rst = [ "vale" ];
      ruby = [ "ruby" ];
      terraform = [ "tflint" ];
      text = [ "vale" ];
      typescript = [ "eslint" ];
      javascript = [ "eslint" ];
      typescriptreact = [ "eslint" ];
      javascriptreact = [ "eslint" ];
      deno = [
        "deno"
        "eslint"
      ];
      haskell = [ "hlint" ];
      python = [ "flake8" ];
      yaml = [
        "ansible_lint"
        "yamllint"
      ];
    };
    autoCmd = {
      # callback = {
      #   __raw = ''
      #     function()
      #       require('lint').try_lint()
      #     end
      #   '';
      # };
      callback = null;
      command = "silent! lua require('lint').try_lint()";
      desc = "Try to lint buffer";
      event = "BufWritePost";
    };
  };
}
