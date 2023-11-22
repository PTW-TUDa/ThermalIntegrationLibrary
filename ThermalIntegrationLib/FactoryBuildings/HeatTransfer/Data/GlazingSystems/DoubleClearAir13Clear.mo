within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.GlazingSystems;
record DoubleClearAir13Clear = Buildings.HeatTransfer.Data.GlazingSystems.Generic (
    final glass={Glasses.GenericGlass_3mm(),Glasses.GenericGlass_3mm()},
    final gas={Buildings.HeatTransfer.Data.Gases.Air(x=0.0129)},
    UFra=1.1) "Double pane, clear glass 3mm, air 13mm, clear glass 3mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGlaSys");
