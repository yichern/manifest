dev:
	pip install -e .[dev]
	pre-commit install

test: dev check
	pytest tests

format:
	isort --atomic manifest/ tests/
	black manifest/ tests/

check:
	isort -c manifest/ tests/
	black manifest/ tests/ --check
	flake8 manifest/ tests/
	mypy manifest/

clean:
	pip uninstall -y manifest
	rm -rf src/manifest.egg-info
	rm -rf build/ dist/

prune:
	@bash -c "git fetch -p";
	@bash -c "for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -d $branch; done";

.PHONY: dev test clean check prune
