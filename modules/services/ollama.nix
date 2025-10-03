{
  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    # loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
    # acceleration = "rocm"; # nope, 5700XT is too old for this
  };
  services.open-webui.enable = false;
}
