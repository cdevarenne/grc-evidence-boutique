# okf-grc-demo-boutique

> **Work in progress.**

[okf-grc](https://github.com/cdevarenne/okf-grc-skill) applied to an app it was
not built around: Google's [microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)
("Online Boutique"), included unmodified as a git submodule at release v0.10.7
under `upstream/`. This repo adds only the compliance layer: the scan layout,
the knowledge bundle, the AI inventory, and CI.

```
git clone --recurse-submodules git@github.com:cdevarenne/okf-grc-demo-boutique.git
make bootstrap   # the pinned scanners
make scan        # out/report.md, OSCAL, run.json
```

The engine version is pinned in the [Makefile](Makefile).

## Issues

This repo is an example, so it has no issue tracker of its own. Its issues live
with the engine, where anyone adopting okf-grc with their own code will look:
[okf-grc-skill issues labeled `adopter-demo`](https://github.com/cdevarenne/okf-grc-skill/issues?q=label%3Aadopter-demo).
