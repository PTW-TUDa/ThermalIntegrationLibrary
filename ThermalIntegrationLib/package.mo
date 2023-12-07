within ;
package ThermalIntegrationLib
  extends ThermalIntegrationLib.BaseClasses.Icons.ThermalIntegrationLibraryPackage;
  import      Modelica.Units.SI;
  import PI = Modelica.Constants.pi;


annotation (uses(
    Buildings(version="8.0.0"),
      Modelica(version="4.0.0"),
      ModelicaServices(version="4.0.0")),
                                        version="1.0.3",
    conversion(from(version="1.0.2", script="modelica://ThermalIntegrationLib/Resources/ConvertFromThermalIntegrationLib_1.0.2.mos")));
end ThermalIntegrationLib;

