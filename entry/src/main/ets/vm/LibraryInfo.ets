import { LibraryListDataSource } from '../model/LibraryListDataSource'

export const getAllLibraryList = (): LibraryListDataSource => {
  // let list = [
  //   'ability_about',
  //   'ability_account',
  //   'ability_bussiness_card',
  //   'ability_category',
  //   'ability_category_list',
  //   'ability_grid',
  //   'ability_list',
  //   'ability_login',
  //   'ability_map',
  //   'ability_splash_screen',
  //   'feature_daojia',
  //   'library_share_common',
  //   'library_static_common',
  // ]
  let list = [
    'Ability_aboutAbility',
    'ability_account',
    'Ability_bussiness_card',
    'Ability_category',
    'Ability_category_list',
    'Ability_grid',
    'Ability_list',
    'Ability_login',
    'Ability_map',
    'Ability_splash_screen',
    'Feature_daojiaAbility',
    'library_share_common',
    'library_static_common',
  ]
  return new LibraryListDataSource(list)
}