within ThermalIntegrationLib.FactoryBuilding.BuildingElements.Test;
model Test_BuildingEnvelope
    extends ThermalIntegrationLib.BaseClasses.BaseFactoryBuilding(
    outsideTemperature=FactoryBuilding.outsideTemperature,
    insideTemperature=FactoryBuilding.insideRoomTemperature,
    ID=1,
    heatDemands=1,
    coolDemands=0,
    electricDemands=0);



  ThermalIntegrationLib.FactoryBuilding.BuildingElements.FactoryBuilding FactoryBuilding annotation (Placement(transformation(extent={{0,0},{20,20}})));

equation
  heatDemand[1].Q_flow[1] =FactoryBuilding.Q_flow;
  heatDemand[1].T_in[1]=FactoryBuilding.outsideTemperature+20;
  heatDemand[1].T_out[1]=FactoryBuilding.insideRoomTemperature;





  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_BuildingEnvelope;
