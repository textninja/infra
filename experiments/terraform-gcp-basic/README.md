# GCP Basic Setup

## Preliminary Setup

To start, we're just spinning up a VPC and some VMs. To use this file with pre-existing secrets, run:

```console
$ make decrypted
```

Of course, if you're not me, or just don't have access to my secrets, the above will fail. In that case, you can create two files of your own, `sa.json` and `variables.yaml`.

`sa.json` is a GCP Service Account JSON secret with editor access to the GCP project you'd like to deploy this to, and `variables.yaml` is a short little YAML file that looks something like this:

```yaml
project: foo-bar-baz-google-project-id
```

## Usage

To deploy the resources defined in this folder, run `terraform apply`.
