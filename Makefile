.PHONY: test
test:	lint cfg

.PHONY: lint
lint:
	@echo "Starting  lint"
	find . -name "*.yml" | xargs yamllint -s
	@echo "Completed lint"

.PHONY: cfg
cfg:
	@echo "Starting  config generation"
	ansible-playbook pb_core.yml --extra-vars="ansible_connection=local"
	@echo "Completed config generation"
