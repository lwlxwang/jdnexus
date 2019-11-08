.DEFAULT_GOAL := test

.PHONY: test
test:	lint clean cfg

.PHONY: lint
lint:
	@echo "Starting  code linting"
	find . -name "*.yml" | xargs yamllint -s
	@echo "Completed code linting"

.PHONY: cfg
cfg:
	@echo "Starting  config generation"
	ansible-playbook pb_core.yml --extra-vars="ansible_connection=local"
	@echo "Completed config generation"

.PHONY: n5548
n5548:
	@echo "Starting  nexus5528 provisioning"
	ansible-playbook pb_nexus5548.yml
	@echo "Completed nexus5528 provisioning"

.PHONY: n93128
n93128:
	@echo "Starting  nexus93128 provisioning"
	ansible-playbook pb_nexus93128.yml
	@echo "Completed nexus93128 provisioning"

.PHONY: clean
clean:
	@echo "Starting  artifact cleanup"
	rm -rf configs
	@echo "Completed artifact cleanup"
