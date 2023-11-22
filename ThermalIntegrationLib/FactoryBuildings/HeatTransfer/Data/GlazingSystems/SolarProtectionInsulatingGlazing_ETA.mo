within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.GlazingSystems;
record SolarProtectionInsulatingGlazing_ETA =
    Buildings.HeatTransfer.Data.GlazingSystems.Generic (
    final glass={Glasses.SafetyGlass_ETA_8mm(),Glasses.SafetyGlass_ETA_8mm()},
    final gas={Buildings.HeatTransfer.Data.Gases.Air(
                         x=0.02)},
    UFra=2) "Double pane, safety glass 13mm, air 20, safety glass 8mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGlaSys");
