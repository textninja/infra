.phony: encrypted decrypted

encrypted:
	gcloud kms encrypt \
		--key=service-account \
		--keyring=infra \
		--location=us-west1 \
		--plaintext-file=sa.json \
		--ciphertext-file=sa.json.encrypted

	gcloud kms encrypt \
		--key=terraform-config \
		--keyring=infra \
		--location=us-west1 \
		--plaintext-file=variables.yaml \
		--ciphertext-file=variables.yaml.encrypted

decrypted:
	gcloud kms decrypt \
		--key=service-account \
		--keyring=infra \
		--location=us-west1 \
		--plaintext-file=sa.json \
		--ciphertext-file=sa.json.encrypted
	
	gcloud kms decrypt \
		--key=terraform-config \
		--keyring=infra \
		--location=us-west1 \
		--plaintext-file=variables.yaml \
		--ciphertext-file=variables.yaml.encrypted
