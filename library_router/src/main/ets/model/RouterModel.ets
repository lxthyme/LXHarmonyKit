import { RouterModule } from '../utils/RouterModule';

export class RouterModel {
  builderName: string = '';
  routerName: string = '';
  param?: object;
}

export const buildRouterModel = (routerName: string, builderName: string, params?: object) => {
  let router = new RouterModel();
  router.builderName = builderName;
  router.routerName = routerName;
  router.param = params;
  RouterModule.push(router);
}