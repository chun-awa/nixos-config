{
  networking.proxy = {
    default = "http://127.0.0.1:7890";
    noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
