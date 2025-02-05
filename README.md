<div align="center">

# asdf-dependabot-cli [![Build](https://github.com/Habluu/asdf-dependabot-cli/actions/workflows/build.yml/badge.svg)](https://github.com/Habluu/asdf-dependabot-cli/actions/workflows/build.yml) [![Lint](https://github.com/Habluu/asdf-dependabot-cli/actions/workflows/lint.yml/badge.svg)](https://github.com/Habluu/asdf-dependabot-cli/actions/workflows/lint.yml)

[dependabot-cli](https://github.com/Habluu/dependabot-cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `ASDF_DEPENDABOT_CLI_OVERWRITE_ARCH`: set this environment variable in your shell config to change the architecture type (ex: `amd64`)

# Install

Plugin:

```shell
asdf plugin add dependabot-cli
# or
asdf plugin add dependabot-cli https://github.com/Habluu/asdf-dependabot-cli.git
```

dependabot-cli:

```shell
# Show all installable versions
asdf list-all dependabot-cli

# Install specific version
asdf install dependabot-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global dependabot-cli latest

# Now dependabot-cli commands are available
dependabot-cli --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/Habluu/asdf-dependabot-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ha](https://github.com/Habluu/)
