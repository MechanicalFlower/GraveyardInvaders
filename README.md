
<div align="center">

# 🕯️ Graveyard Invaders

![Godot Badge](https://img.shields.io/badge/godot-4.3-blue?logo=Godot-Engine&logoColor=white)
![license](https://img.shields.io/badge/license-MIT-green?logo=open-source-initiative&logoColor=white)
![reuse](./.reuse/REUSE-compliant.svg)

A boss rush game, made with [Godot Engine](https://godotengine.org/).

<a href="https://github.com/mechanicalflower/GraveyardInvaders/releases/" target="_blank"><img src="public/publishing/store/github.webp" alt="Download on Github" height="40px" ></a>
<a href="https://mechanical-flower.itch.io/graveyardinvaders" target="_blank"><img src="public/publishing/store/itchio.webp" alt="Download on itch.io" height="40px" ></a>

</div>

## About

Dodge, attack, and survive against spooky monsters!

## Installation

### From a release

Released binaries are available
on the Github repository, in the release section.

Download the zip archive, accordingly to your OS, and unzip it.

- **Windows**: Double click on `GraveyardInvaders.exe`.
- **MacOS**: Double click on `GraveyardInvaders.app`.
- **Linux**: In a terminal, run `./GraveyardInvaders.x86_64`.

### From source

> [!IMPORTANT]
> For this installation, you need to have
> the Godot Editor installed.

Clone the source locally:
```
git clone https://github.com/MechanicalFlower/GraveyardInvaders.git
```

You need to install addons first:
```
godot --headless --script plug.gd install
```

And simply run the game as any Godot project:
```
godot
```

## Development

The project use:
- [`just`](https://just.systems/man/en/) as command runner,
- [`pre-commit`](https://pre-commit.com/) to run formatters, this requires [Python 3](https://docs.python.org/3/).

> [!IMPORTANT]
> Actually, `just` recipes only support Linux.

To check all available recipes, run:
```
just
```

To run formatters:
```
just fmt
```

To install, and run the game:
```
just install-addons
just godot
```

> [!TIP]
> In `just` recipes, the Godot Editor is installed
> automatically. This ensure that you
> use the right version of the engine.

## Contributing

![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)

We welcome community contributions to this project.

Please read our [Contributor Guide](CONTRIBUTING.md) for more information on how to get started.

## Releasing

Please read our [Release Guide](RELEASING.md) for more information on how we manage our releases.
