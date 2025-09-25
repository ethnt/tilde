{
  xdg.configFile."ghc/ghci.conf".text = ''
    :set prompt "\x03BB> "
    :set prompt-cont " > "

    :seti -XPartialTypeSignatures
    :seti -XScopedTypeVariables
    :seti -XTypeApplications
    :seti -XOverloadedStrings
  '';
}
