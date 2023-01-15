.PHONY: provision
provision: apply

.PHONY: plan
plan: init validate
	terraform plan 

.PHONY: apply
apply: init validate
	terraform apply -auto-approve

.PHONY: init
init:
	terraform init --upgrade

.PHONY: destroy
destroy: 
	terraform destroy

.PHONY: validate
validate:
	terraform validate

.PHONY: build-image
build-image:
	docker build -t ${REPO}/s3-bench:latest deploy/

.PHONY: push-image
push-image:
	docker push ${REPO}/s3-bench:latest

