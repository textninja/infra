import * as pulumi from '@pulumi/pulumi';
import * as docker from '@pulumi/docker';

const stack = pulumi.getStack();

const backendImageName = 'backend';
const frontendImageName = 'frontend';

const backend = new docker.Image('backend', {
  build: {
    context: `${process.cwd()}/app/backend`
  },
  imageName: `${backendImageName}:${stack}`,
  skipPush: true
});

const frontend = new docker.Image('frontend', {
  build: {
    context: `${process.cwd()}/app/frontend`
  },
  imageName: `${frontendImageName}:${stack}`,
  skipPush: true
});
