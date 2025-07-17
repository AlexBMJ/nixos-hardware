{lib, ...}: {
  imports = [
    ./common
    ./common/amd.nix
    ./common/audio.nix
  ];

  options = {
    hardware.gpd.duo.preventWakeOnAC = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Stop the system waking from suspend when the AC is plugged
        in. The catch: it also disables waking from the keyboard.

        See:
        https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128/45
      '';
    };
  };

  config = {
    # Replace 'left' with 'right' or 'inverted' as needed
    # Fixes DUO stupid inverted display at boot
    # Enable kernel module for your graphics (adjust if needed)
    boot.kernelModules = ["amdgpu"];

    # Set the eDP-1 panel video parameters for display rotation
    boot.kernelParams = [
      "video=eDP-1:panel_orientation=upside_down"
    ];

    hardware.gpd.duo.audioEnhancement.rawDeviceName = lib.mkDefault "alsa_output.pci-0000_c1_00.6.analog-stereo";
  };
}
