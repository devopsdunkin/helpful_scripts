MAKEFLAGS=--silent
.PHONY: bash_profile tf-new-workspace tf-init tf-validate tf-plan tf-apply tf-fmt

bash_profile:
  cp .bash_profile /Users/$(whoami)

check-env:
ifndef env
	$(error Variable `env` not provided)
endif
  
tf-init:
	docker run \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-v ~/.ssh:/root/.ssh \
		-v ~/.gitconfig:/root/.gitconfig \
		-v ~/.config:/root/.config \
		-w /usr/src \
		--entrypoint /usr/scripts/tf-init.sh \
	 	hashicorp/terraform:${TERRAFORM_VERSION}

tf-fmt:
	docker run \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-w /usr/src \
		--entrypoint /usr/scripts/tf-fmt.sh \
		hashicorp/terraform:${TERRAFORM_VERSION}

tf-new-workspace: check-env
	docker run \
		-e ENV=$$env \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-v ~/.config:/root/.config \
		-w /usr/src \
		--entrypoint /usr/scripts/tf-new-workspace.sh \
		hashicorp/terraform:${TERRAFORM_VERSION}

tf-validate: check-env
	docker run \
		-e ENV=$$env \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-v ~/.ssh:/root/.ssh \
		-v ~/.gitconfig:/root/.gitconfig \
		-v ~/.config:/root/.config \
		-w /usr/src \
		-it \
		--entrypoint /usr/scripts/tf-validate.sh \
	 	hashicorp/terraform:${TERRAFORM_VERSION}

tf-plan: check-env
	docker run \
		-e ENV=$$env \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-v ~/.ssh:/root/.ssh \
		-v ~/.gitconfig:/root/.gitconfig \
		-v ~/.config:/root/.config \
		-w /usr/src \
		-it \
		--entrypoint /usr/scripts/tf-plan.sh \
	 	hashicorp/terraform:${TERRAFORM_VERSION}

tf-apply: check-env
	docker run \
		-e ENV=$$env \
		-v $$(pwd)/scripts:/usr/scripts \
		-v $$(pwd)/tf:/usr/src \
		-v ~/.ssh:/root/.ssh \
		-v ~/.gitconfig:/root/.gitconfig \
		-v ~/.config:/root/.config \
		-w /usr/src \
		--entrypoint /usr/scripts/tf-apply.sh \
		-it \
	 	hashicorp/terraform:${TERRAFORM_VERSION}
