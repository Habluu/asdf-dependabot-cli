# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test dependabot-cli https://github.com/Habluu/asdf-dependabot-cli.git "dependabot --help"
```

Tests are automatically run in GitHub Actions on push and PR.
