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
	python3.7 -m venv .venv
	source .venv/bin/activate
	pip3 install wheel
	pip3 install poetry
	deactivate

.PHONY: install-production-package ## Install production package (from pypi.org) using poetry
install-production-package:
	source .venv/bin/activate
	poetry install pandas

.PHONY: install-dev-package ## Install dev package (from pypi.org) using poetry
install-dev-package:
	source .venv/bin/activate
	poetry install -D pytest

.PHONY: clean-venv ## Clean virtual environment (local dev)
clean-venv:
	rm -rf .venv/
