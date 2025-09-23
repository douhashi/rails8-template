# Rails 8 Template

A modern Rails 8 application template with best practices and essential configurations.

## Features

- Rails 8 with Propshaft
- ViewComponent for UI components
- Lookbook for component development
- Solid Queue for background jobs
- Foreman for process management
- Structured documentation system

## Getting Started

```bash
# Install dependencies
bundle install
npm install

# Setup database
bin/rails db:setup

# Start development server (runs on port 5100)
bin/server
```

## Development with Dev Container

(douhashi/devcontainer-rails)[https://github.com/douhashi/devcontainer-rails]

```
git subtree add --prefix=.devcontainer --squash git@github.com:douhashi/devcontainer-rails.git main
```

### Using Dev Container CLI

For command-line usage, use the provided scripts:

```bash
# Rebuild the container (useful after configuration changes)
.devcontainer/bin/rebuild

# Start the dev container
.devcontainer/bin/up

# Stop the dev container
.devcontainer/bin/down
```

These scripts wrap the devcontainer CLI commands for easier management of the development environment.

## Documentation

Project documentation is organized under `docs/`:
- `business/` - Business documents
- `development/` - Development guides
- `operations/` - Operational documents
