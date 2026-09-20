# dev/

Local VM sandbox for testing `infrastructure/` end-to-end — a real Ubuntu
24.04 box with real systemd, so `docker-ce`, Homebrew, and mise actually get
installed the way they would on a real machine — before trusting a change on
a real machine.

For fast syntax/lint checks that don't need a VM, see
[`infrastructure/test/`](../infrastructure/test/) instead.

## Prerequisites (host, one-time)

This assumes Vagrant and libvirt are already installed on the host. That
install isn't automated here — it's a one-time hypervisor setup, not
something to repeat on every run. On Ubuntu:

```bash
sudo apt-get install -y vagrant libvirt-daemon-system libvirt-clients qemu-kvm
sudo usermod -aG libvirt "$USER"   # log out/in (or `newgrp libvirt`) to apply
vagrant plugin install vagrant-libvirt
```

## Usage

```bash
vagrant up                         # boot a fresh Ubuntu 24.04 VM, run bootstrap.sh
vagrant rsync && vagrant provision # after editing infrastructure/, re-sync + re-run
vagrant ssh                        # poke around inside the VM
vagrant destroy                    # tear down, start clean next time
```

Re-running `bootstrap.sh` on an already-provisioned VM via `vagrant provision`
also doubles as an idempotency check — most tasks should report `changed=0`
on the second run.
