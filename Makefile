.PHONY: help
WORKFLOW_VERSION := `plutil -extract version xml1 -o - info.plist | sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p"`

help: ## show this help message and exit
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

update_version: ## update workflow version
	@read -p 'version: ' version; \
	plutil -replace version -string $$version info.plist;

version: ## get current workflow version
	@echo "${WORKFLOW_VERSION}"

build: ## build .alfredworkflow file
	@make clean;
	@yarn;
	@mkdir -p dist/output; \
	cp qr_code.js icon.png info.plist package.json dist/output; \
	cp -r node_modules dist/output/node_modules;
	@cd dist/output && zip -q -r -D ../qr-code.alfredworkflow *;

clean: ## Clean build and archive files
	@rm -rf dist;

archive: ## archive .zip file
	@make build; \
	version=${WORKFLOW_VERSION}; \
	cd dist && zip -q -r -o workflow-qr-code-$$version.zip qr-code.alfredworkflow;