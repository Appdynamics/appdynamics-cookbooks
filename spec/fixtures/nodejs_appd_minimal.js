require("appdynamics").profile({
  controllerHostName: 'controller-host',
  controllerPort: 1234,
  controllerSslEnabled: true,
  applicationName: 'app-name',
  tierName: 'tier-name',
  nodeName: 'node-name'
});
