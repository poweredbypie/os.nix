# Mouse config

{ ... }:

{
  wayland.windowManager.sway.config.input = {
    # Disable pointer acceleration
    "*".accel_profile = "flat";
    # Lower sensitivity
    "5426:138:Razer_Razer_Viper_Mini".pointer_accel = "-0.2";
  };
}
