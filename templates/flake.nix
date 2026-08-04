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
    };
  };
}