# Import environment variables config.
# You can change the default config with `make cnf="config_app.env" build`
# cnf ?= aapp.env
# include $(cnf)
# export $(shell sed 's/=.*//' $(cnf))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This is help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
build: ## Build the container for ensightcloud
	docker build -t arch-multitool:arm .

build-aws: ## Build the container for wunderground
	docker build -f Dockerfile.aws -t arch-multitool:aws .

build-gc: ## Build the container for wunderground
	docker build -f Dockerfile.gcloud -t arch-multitool:gc .

clean: ## Clean orphaned containers and images
	docker container prune -f && docker image prune -f

run:
	docker run -it --name="arm-multitool" \
	-v ${PWD}/starship.toml:/root/.config/starship.toml \
	-v ${PWD}/.bashrc.alpine:/root/.bashrc \
	-v ${PWD}/.terraform_aliases:/root/.terraform_aliases \
	-v ${PWD}/.terragrunt_aliases:/root/.terragrunt_aliases \
	-v ${HOME}/.ssh/rt:/root/.ssh \
	-v ${HOME}/.aws/rt:/root/.aws \
	-v ${HOME}/Work/sync:/root/Work \
	-w /root/Work \
	arch-multitool:arm

run-i2g:
	docker run -it --name="i2g-acw" \
	-v ${PWD}/starship.toml:/root/.config/starship.toml \
	-v ${PWD}/.bashrc.alpine:/root/.bashrc \
	-v ${HOME}/Work/sync/i2g:/root/Work \
	-w /root/Work \
	mcr.microsoft.com/azure-cli

run-aws: ## Run container for wunderground
	docker run -it --name="acw" \
	-v ${HOME}/.ssh/wx/:/root/.ssh/ \
	-v ${PWD}/starship.toml:/root/.config/starship.toml \
	-v ${PWD}/.bashrc:/root/.bashrc \
	-v ${PWD}/.terraform_aliases:/root/.terraform_aliases \
	-v ${HOME}/Work/wmwx:/root/Work \
	-w /root/Work \
	arch-multitool:aws

run-gc: ## Run container for gcloud
	docker run -it --name="gcw" \
	-v ${HOME}/.ssh/:/root/.ssh/ \
	-v ${PWD}/starship.toml:/root/.config/starship.toml \
	-v ${PWD}/.bashrc.alpine:/root/.bashrc \
	-v ${HOME}/Work/dd:/root/Work \
	-w /root/Work \
	arch-multitool:gc