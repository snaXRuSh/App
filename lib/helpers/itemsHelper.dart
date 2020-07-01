import '../constants/IdPrefix.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../services/interface/IGameItemJsonService.dart';
import '../services/interface/IRecipeJsonService.dart';

LocaleKey getLangJsonFromItemId(String itemId) {
  if (itemId.contains(IdPrefix.recipeCookBot))
    return LocaleKey.cookBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeCraftBot))
    return LocaleKey.craftBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeDispenser))
    return LocaleKey.dispenserRecipeJson;
  if (itemId.contains(IdPrefix.recipeDressBot))
    return LocaleKey.dressBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeHideOut))
    return LocaleKey.hideOutRecipeJson;
  if (itemId.contains(IdPrefix.recipeRefinery))
    return LocaleKey.refineryRecipeJson;
  if (itemId.contains(IdPrefix.recipeWorkbench))
    return LocaleKey.workbenchRecipeJson;

  return LocaleKey.unknown;
}

ResultWithValue<IRecipeJsonService> getRecipeRepoFromId(context, String id) {
  LocaleKey key = getLangJsonFromItemId(id);

  if (key != LocaleKey.unknown) {
    return ResultWithValue<IRecipeJsonService>(true, getRecipeRepo(key), '');
  }

  logger.e('getRecipeRepoFromId - unknown type of item: $id');
  return ResultWithValue<IRecipeJsonService>(
      false, null, 'getRecipeRepoFromId - unknown type of item: $id');
}

ResultWithValue<IGameItemJsonService> getGameItemRepoFromId(
    context, String id) {
  LocaleKey key = LocaleKey.title;

  if (id.contains(IdPrefix.blocks)) key = LocaleKey.blocksJson;
  if (id.contains(IdPrefix.building)) key = LocaleKey.buildingJson;
  if (id.contains(IdPrefix.construction)) key = LocaleKey.constructionJson;
  if (id.contains(IdPrefix.consumable)) key = LocaleKey.consumableJson;
  if (id.contains(IdPrefix.containers)) key = LocaleKey.containersJson;
  if (id.contains(IdPrefix.craftbot)) key = LocaleKey.craftbotJson;
  if (id.contains(IdPrefix.customisation)) key = LocaleKey.customisationJson;
  if (id.contains(IdPrefix.decor)) key = LocaleKey.decorJson;
  if (id.contains(IdPrefix.gitting)) key = LocaleKey.gittingJson;
  if (id.contains(IdPrefix.harvest)) key = LocaleKey.harvestJson;
  if (id.contains(IdPrefix.industrial)) key = LocaleKey.industrialJson;
  if (id.contains(IdPrefix.interactive)) key = LocaleKey.interactiveJson;
  if (id.contains(IdPrefix.interactiveUpgradable))
    key = LocaleKey.interactiveUpgradableJson;
  if (id.contains(IdPrefix.interactiveContainer))
    key = LocaleKey.interactiveContainerJson;
  if (id.contains(IdPrefix.light)) key = LocaleKey.lightJson;
  if (id.contains(IdPrefix.manMade)) key = LocaleKey.manMadeJson;
  if (id.contains(IdPrefix.other)) key = LocaleKey.otherJson;
  if (id.contains(IdPrefix.outfit)) key = LocaleKey.outfitJson;
  if (id.contains(IdPrefix.packingCrate)) key = LocaleKey.packingCrateJson;
  if (id.contains(IdPrefix.plant)) key = LocaleKey.plantJson;
  if (id.contains(IdPrefix.power)) key = LocaleKey.powerJson;
  if (id.contains(IdPrefix.resources)) key = LocaleKey.resourcesJson;
  if (id.contains(IdPrefix.robot)) key = LocaleKey.robotJson;
  if (id.contains(IdPrefix.scrap)) key = LocaleKey.scrapJson;
  if (id.contains(IdPrefix.spaceship)) key = LocaleKey.spaceshipJson;
  if (id.contains(IdPrefix.survival)) key = LocaleKey.survivalJson;
  if (id.contains(IdPrefix.tool)) key = LocaleKey.toolJson;
  if (id.contains(IdPrefix.vehicle)) key = LocaleKey.vehicleJson;
  if (id.contains(IdPrefix.warehouse)) key = LocaleKey.warehouseJson;

  if (key != LocaleKey.title) {
    return ResultWithValue<IGameItemJsonService>(
        true, getGameItemRepo(key), '');
  }

  logger.e('getGameItemRepoFromId - unknown type of item: $id');
  return ResultWithValue<IGameItemJsonService>(
      false, null, 'getGameItemRepoFromId - unknown type of item: $id');
}
