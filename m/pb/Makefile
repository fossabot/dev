limit ?= $(shell uname -n)
opt ?= -l "$(limit)"

second = $(word 2, $(subst -, ,$@))

build:
	cue fmt ./...
	rm -f playbooks/*.yaml
	rm -rf roles
	cue export --out json -e fs | jq -r 'to_entries[] | "\(.key) \(.value | @base64)"' | ../c/decode_base64.py 

report:
	@echo; (cd dump && cue export --out json) | jq -r '.host | to_entries[] | .key as $$host | .value as $$facts | $$facts.ansible_processor | "\($$host) \($$facts.ansible_processor_nproc) \(.[2])"' | talign 2

$(HOME)/.local/bin/ansible-playbook:
	pipx install --include-deps ansible

playbooks/*.yaml: playbooks.cue
	$(MAKE) build

local-%:
	@ansible-playbook -i inventory/packer.ini -e ansible_connection=local "playbooks/$(second).yaml"

%: $(HOME)/.local/bin/ansible-playbook playbooks/%.yaml
	@ansible-playbook $(opt) "playbooks/$@.yaml"
