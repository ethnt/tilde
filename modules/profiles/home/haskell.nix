{
  xdg.configFile."ghc/ghci.conf".text = ''
    :seti -XPartialTypeSignatures
    :seti -XScopedTypeVariables
    :seti -XTypeApplications
    :seti -XOverloadedStrings
  '';
}
