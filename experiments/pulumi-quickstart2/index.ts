import * as pulumi from '@pulumi/pulumi';
import * as docker from '@pulumi/docker';

const config = new pulumi.Config;
const frontendPort = config.requireNumber('frontend_port');
const backendPort = config.requireNumber('backend_port');
const mongoPort = config.requireNumber('mongo_port');

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

const mongoImage = new docker.RemoteImage('mongo', {
  name: 'mongo:bionic'
});
