
export class RouterModel {
  builderName: string = '';
  routerName: string = '';
  params?: object;
}

export const buildRouterModel = (routerName: string, builderName: string, params?: object) => {
  let router = new RouterModel();
  router.builderName = builderName;
  router.routerName = routerName;
  router.params = params;
  // RouterM
}