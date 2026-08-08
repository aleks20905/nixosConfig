{
  description = "templates";

  outputs = { self }: {
    templates = {
      go = {
        path = ./go;
        description = "Go template";
      };

      python = {
        path = ./python;
        description = "python template";
      };

      py = {
        path = ./python;
        description = "python template";
      };

      zig = {
        path = ./zig;
        description = "zig template";
      };

      rust = {
        path = ./rust;
        description = "rust template";
      };

      c = {
        path = ./c;
        description = "c template";
      };

      empty = {
        path = ./empty;
        description = "empty template";
      };

      haskell = {
        path = ./haskell;
        description = "haskell template";
      };
      
    };
  };
}

