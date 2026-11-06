# EESSI Terminal

A browser-based terminal with the [EESSI](https://www.eessi.io/docs/)
scientific software stack preloaded. Researchers get a shell where
`module avail` lists thousands of optimized HPC applications — GROMACS,
OpenFOAM, PyTorch, QuantumESPRESSO — without building images or maintaining
conda environments.

## How it works

EESSI is distributed over [CernVM-FS](https://cernvm.cern.ch/fs/). The
[cvmfs-csi](https://github.com/cvmfs-contrib/cvmfs-csi) driver runs a DaemonSet
on each worker node that mounts the repository and exposes it to pods through a
PersistentVolumeClaim, so only the driver needs privileges — user pods keep
running under `restricted-v2`.

## Contents

| Path | Purpose |
| --- | --- |
| `Dockerfile` | Terminal image: [ttyd](https://github.com/tsl0922/ttyd) plus tmux, git, ssh and the usual shell tools |
| `entrypoint.sh` | Gives OpenShift's random UID a name in `/etc/passwd` and `/etc/group` |
| `.github/workflows/publish-docker-image.yml` | Builds the image and pushes it to GHCR |

## Image

Published to `ghcr.io/maastrichtu-ids/eessi-terminal`, tagged `latest` and
`sha-<commit>` on every push to `main` that touches the image files.

## Using EESSI

```bash
module avail                    # browse what's available
module load GROMACS             # load an application
```
