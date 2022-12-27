DD_API_KEY?=''
TARGET_OPTS?=

ifdef TARGET
	TARGET_OPTS = '-l $(TARGET)'
endif

setup:
	@ansible-playbook -i inventory/hosts -e 'target=seed password=$(PASSWORD) dd_api_key=$(DD_API_KEY) provider=$(PROVIDER)' $(TARGET_OPTS) setup.yml

launch:
	@ansible-playbook -i inventory/hosts -e 'target=seed container_name=$(CHAIN_ID) host_port=$(PORT) chain_id=$(CHAIN_ID) seeds=$(SEEDS)' $(TARGET_OPTS) launch.yml
