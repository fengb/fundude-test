FROM nixos/nix

RUN nix-env -i \
        gnumake \
        rgbds

WORKDIR /opt/fundude-test
