# You found it. 👋

If you're here, chances are you're like me:

You enjoy NixOS, but you're not quite sold on Flakes or Home Manager yet.

Maybe you've also opened someone else's configuration repository and wondered:

> "Where is the actual configuration?"

This folder is my attempt to answer that question.

Ignore everything outside this directory.

Ignoring `hardware-configuration.nix`, there are really only **three `.nix` files** and **one symbolic link**.

```text
configuration.nix
machine.nix (optional, if you use one)
hosts/
├── your-host/
│   ├── default.nix
│   └── hardware-configuration.nix

host.link
```

Getting started is simple:

1. Clone (or copy) this `nixos/` directory to `/etc/nixos`.
2. Create your own folder under `hosts/`.
3. Copy your `hardware-configuration.nix`.
4. Edit `hosts/<your-host>/default.nix`.
5. Point `host.link` to your host:

```bash
ln -sf hosts/<your-host>/default.nix host.link
```

That's it.

```bash
sudo nixos-rebuild switch
```

No Flakes.

No Home Manager.

No hunting through dozens of modules.

Just enough structure to support multiple machines while keeping everything easy to find.

If you understand these few files, you understand the whole system.

Happy hacking. 🚀
