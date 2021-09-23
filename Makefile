.PHONY: help
WORKFLOW_VERSION := `plutil -extract version xml1 -o - qr-code/info.plist | sed -n "s/.*<string>\(.*\)<\/string>.*/\1/p"`

help: ## show this help message and exit
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

update_version: ## update workflow version
	@read -p 'version: ' version; \
	plutil -replace version -string $version qr-code/info.plist;

version: ## get current workflow version
	@echo "${WORKFLOW_VERSION}"

build: ## build .alfredworkflow file
	@make clean;
	@yarn;
	@mkdir -p dist; \
	cp -r qr-code dist/output; \
	cp -r node_modules dist/output/node_modules; \
	zip -q -r dist/qr-code.alfredworkflow dist/output/*;

clean: ## Clean build and archive files
	@rm -rf dist

archive: ## archive .zip file
	@make build; \
	zip -q -r -o dist/workflow-qr-code-${WORKFLOW_VERSION}.zip dist/qr-code.alfredworkflow