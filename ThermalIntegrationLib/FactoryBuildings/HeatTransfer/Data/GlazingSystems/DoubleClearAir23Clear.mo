within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.GlazingSystems;
record DoubleClearAir23Clear = Buildings.HeatTransfer.Data.GlazingSystems.Generic (
    final glass={Glasses.GenericGlass_3mm(),Glasses.GenericGlass_3mm()},
    final gas={Buildings.HeatTransfer.Data.Gases.Air(x=0.0225)},
    UFra=1.1) "Double pane, clear glass 3mm, air 23, clear glass 3mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGlaSys");
