.PHONY: help
help:
	@echo 
	@grep '##' Makefile | grep -v grep

.PHONY: provision
provision: 		## provision infrastructure with terraform
provision: apply

.PHONY: 
plan:			## show terraform plan
plan: init validate
	terraform plan 

.PHONY: apply
apply:			## run terraform apply with -auto-approve			
apply: init validate
	terraform apply -auto-approve

.PHONY: init
init:			## run terraform init
init:
	terraform init --upgrade

.PHONY: destroy
destroy:		## run terraform destroy
destroy: 
	terraform destroy

.PHONY: validate
validate:		## run terraform validate
validate:
	terraform validate

.PHONY: fmt
fmt:			## run terraform fmt
fmt:
	terraform fmt

.PHONY: build-image
build-image:		## build image based on created ecr registry. You must `make provision` first
build-image:
	docker build -t `terraform output --raw registry_url`:latest image/

.PHONY: push-image
push-image:		## push test image, You must `make provision` first.
push-image:
	@aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin `terraform output --raw registry_url
	docker push  `terraform output --raw registry_url`:latest

.PHONY: helm-deploy
helm-deploy:		## install the s3bench deployment. You must `make provision` first
helm-deploy:
	@helm upgrade --install s3bench s3bench/ \
	--set s3benchConfig.accessKey=`terraform output --raw s3_user_key` \
	--set s3benchConfig.secretKey=`terraform output --raw s3_user_access_key` \
	--set s3benchConfig.bucketName=`terraform output --raw bucket_name` \
	--set s3benchConfig.image=`terraform output --raw registry_url`:latest

.PHONY: helm-undeploy
helm-undeploy:		## uninstall the s3bench deployment
helm-undeploy:
	helm uninstall s3bench
