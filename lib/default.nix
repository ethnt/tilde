{ lib }:
lib.makeExtensible
(self: let callLibs = file: import file { lib = self; }; in rec { })
