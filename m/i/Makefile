fmt: # Format packer configs
	packer fmt -write=true .

hello:
	test "$$(pass hello)" == world

# cleaning
clean-ami:
	$(MAKE) clean-ami-prefix prefix="base-*"
	$(MAKE) clean-ami-prefix prefix="coder-*"

clean-ami-prefix:
	aws ec2 describe-images --owners self --filters "Name=name,Values=$(prefix)" "Name=state,Values=available" --query 'Images | sort_by(@, &CreationDate) | reverse(@)' | jq -r '.[].ImageId' | tail -n +2 | runmany 'set -x; aws ec2 deregister-image --image-id $$1'

clean-snapshot:
	comm -23 <(aws ec2 describe-snapshots --owner-ids self --query 'Snapshots[*].SnapshotId' --filters "Name=description,Values=Created by CreateImage*" | jq -r '.[]' | sort) <(aws ec2 describe-images --owners self --query 'Images[*].BlockDeviceMappings[*].Ebs.SnapshotId' --output text | sort) | runmany 'set -x; aws ec2 delete-snapshot --snapshot-id $$1'SHELL := /bin/bash

reset:
	@echo --- pruning
	sudo chown ubuntu:ubuntu /var/run/docker.sock
	cd ../../cache && docker compose down && $(MAKE) up
	this-prune

# all
all-docker:
	$(MAKE) buildkite
	$(MAKE) root
	$(MAKE) class
	$(MAKE) class-buildkite-latest

all-ami:
	$(MAKE) base
	$(MAKE) coder

# latest
latest-docker:
	$(MAKE) class-buildkite-latest

latest-ami:
	$(MAKE) coder

root:
	earthly --ci --no-cache --no-output --push +root

# docker
buildkite:
	@echo --- earthly
	sudo chown ubuntu:ubuntu /var/run/docker.sock
	docker ps || sudo docker ps
	earthly --ci --push --no-output +buildkite

class:
	@echo --- earthly 
	sudo chown ubuntu:ubuntu /var/run/docker.sock
	earthly --ci --push --no-output +class

class-buildkite-latest:
	@echo --- earthly
	sudo chown ubuntu:ubuntu /var/run/docker.sock
	earthly --ci --push --no-output +class-buildkite-latest

# ami
%:
	$(MAKE) hello
	packer init $@.pkr.hcl
	b exec defn-org env AWS_REGION=us-west-2 packer build -color=true -timestamp-ui=true $@.pkr.hcl
