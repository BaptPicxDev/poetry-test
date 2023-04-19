SHELL := /bin/bash
.SHELLFLAGS = -ec
.ONESHELL:
.SILENT:

.PHONY: help
help:
	grep -E '^\.PHONY: [a-zA-Z0-9_-]+ .*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = "(: |##)"}; {printf "\033[36m%-30s\033[0m %s\n", $$2, $$3}'

.PHONY: build-venv ## Create virtual environment and install requirements (local dev)
build-venv:
	echo "Creating python3 virtual environment with poetry"
	make install-production-packages
	make install-dev-packages
	poetry install

.PHONY: add-production-packages ## Add production package to pyproject.toml (from pypi.org) using poetry
add-production-packages:
	echo "Adding production packages"
	poetry add pandas
	poetry add numpy

.PHONY: add-dev-packages ## Add dev package to pyproject.toml(from pypi.org) using poetry
add-dev-packages:
	echo "Installing dev packages"
	poetry add --group dev pytest
	poetry add --group dev pytest-cov
	poetry add --group dev pytest-mock
	poetry add --group dev pylint

.PHONY: check-dependencies ## Ensure that all dependencies are installed
check-dependencies:
	echo "Ensure dependencies are installed"
	poetry check

.PHONY: run-pytest ## Run pytest using pytest
run-pytest:
	echo "Running pytest"
	poetry run pytest -vv --cov=src/ tests/

.PHONY: clean-venv ## Clean virtual environment (local dev)
clean-venv:
	echo "Removing python3 virtual environment using poetry"
