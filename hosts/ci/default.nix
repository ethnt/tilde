{ suites, darwin, ... }: { imports = with suites; (base ++ terminal); }
