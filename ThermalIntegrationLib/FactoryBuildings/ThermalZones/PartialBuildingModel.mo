within ThermalIntegrationLib.FactoryBuildings.ThermalZones;
partial model PartialBuildingModel

  // --- RecordSummary ---
  ResultSummaryZone resultSummary(
    Q_flow_heating=Q_flow_heat_ideal,
    Q_flow_cooling=Q_flow_cool_ideal,
    T_room=insideRoomTemperature,
    T_operative=operativeRoomTemperature,
    T_in=0,
    T_out=0);

  // --- Connectors ---
  Modelica.Blocks.Interfaces.RealInput T_ground(displayUnit="degC") if nGroundFloor>0 "Ground temperature for floor boundary condition" annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-11,-115}), iconTransformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={-11,-115})));
  Modelica.Blocks.Interfaces.RealInput Q_gainConv(unit="W/m2") if useHeatInputConv "Convective heat gain per m2 e.g. by machines" annotation (Placement(transformation(extent={{-130,-98},{-100,-68}}), iconTransformation(extent={{-130,-98},{-100,-68}})));
  Modelica.Blocks.Interfaces.RealInput Q_gainRad(unit="W/m2") if useHeatInputRad "Radiative heat gain per m2 e.g. by machines" annotation (Placement(transformation(extent={{-130,-68},{-100,-38}}), iconTransformation(extent={{-130,-68},{-100,-38}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b fPorts[nFPorts](
  redeclare each package Medium = MediumAir) if useFluidPorts "Fluid ports to air volume" annotation (Placement(transformation(
        extent={{-40,-10},{40,10}},
        origin={-104,34},
        rotation=90), iconTransformation(
        extent={{-40,-10},{40,10}},
        rotation=90,
        origin={-110,50})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortAir if useHeatPortAir "Heat port to air volume" annotation (Placement(transformation(extent={{-98,90},{-76,112}}), iconTransformation(extent={{-98,90},{-76,112}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad if useHeatPortRad "Heat port for radiative heat gain and radiative temperature" annotation (Placement(transformation(extent={{-58,90},{-36,112}}), iconTransformation(extent={{-58,90},{-36,112}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surf_conBou[nConBou-nGroundFloor] if
    nConBou>nGroundFloor "Heat port at surface b of construction conBou" annotation (
      Placement(transformation(extent={{56,-114},{76,-94}}),
        iconTransformation(extent={{72,-120},{92,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surf_conTABS[nConTABS] if
    nConTABS>0 "Heat port of surface that is connected to the TABS" annotation (Placement(transformation(extent={{34,-114},{54,-94}}), iconTransformation(extent={{48,-120},{68,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surf_surBou[nSurBou] if
    nSurBou>nConTABS "Heat port of surface that is connected to the room air"
    annotation (Placement(transformation(extent={{12,-114},{32,-94}}),
        iconTransformation(extent={{24,-120},{44,-100}})));
  Modelica.Fluid.Interfaces.FluidPort_a portTABS_a[nConTABS](redeclare package Medium =MediumTABS) if nConTABS>0 annotation (Placement(transformation(extent={{-120,-24},{-100,-4}}), iconTransformation(extent={{-120,-24},{-100,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_b portTABS_b[nConTABS](redeclare package Medium =MediumTABS) if nConTABS>0 annotation (Placement(transformation(extent={{-84,-120},{-64,-100}}), iconTransformation(extent={{-84,-120},{-64,-100}})));

 // --- Parameters ---
  constant Modelica.SIunits.Temperature T_start=293.15 "Initial room temperature" annotation(Dialog(group="Building",tab="General"));
  parameter Real thMassFactor(min=1)=1 "Factor for scaling the sensible thermal mass of the air volume" annotation(Dialog(group="Building",tab="General"));
  parameter Modelica.SIunits.Angle latitude=0.87266462599716 "Latitude of the location" annotation(Dialog(group="Building",tab="General"));
  // Geometry
  parameter Boolean hasRectBaseArea=true "Set to false if base area of the building is not rectangular" annotation(Dialog(group="Geometry",tab="Constructions"));
  parameter Modelica.SIunits.Area baseArea=0 "Base area of the building" annotation(Dialog(enable=not hasRectBaseArea,group="Geometry",tab="Constructions"));
  parameter Modelica.SIunits.Length length "Length of the cuboid thermal zone" annotation(Dialog(enable=hasRectBaseArea,group="Geometry",tab="Constructions"));
  parameter Modelica.SIunits.Length width "Width of the cuboid thermal zone" annotation(Dialog(enable=hasRectBaseArea,group="Geometry",tab="Constructions"));
  parameter Modelica.SIunits.Length zoneHeight "Height of the thermal zone" annotation(Dialog(group="Geometry",tab="Constructions"));
  parameter Modelica.SIunits.Area envelopeArea=2*zoneHeight*(length+width)+length*width "Envelope area in contact with outside air" annotation(Dialog(group="Geometry",tab="Constructions"));
  // Heat gains
  parameter Boolean useHeatPortAir=false "Use a heat port for the connection of the zone air volume" annotation(Dialog(
   group="Connectors",
   tab="General"));
  parameter Boolean useHeatPortRad=false "Use a heat port for the connection of zone radiative gains and operational temperature" annotation(Dialog(
   group="Connectors",
   tab="General"));
  parameter Boolean useFluidPorts=false "Use a fluid port for the connection of the air volume and the production equipment" annotation(Dialog(group="Connectors",tab="General"));
  parameter Boolean useHeatInputConv=true "Use a Real input for convective heat gains to the thermal zone" annotation(Dialog(group="Connectors",tab="General"));
  parameter Boolean useHeatInputRad=true "Use a Real input for radiative heat gains to the thermal zone" annotation(Dialog(group="Connectors",tab="General"));
  parameter Integer nFPorts(min=0)=0 "Number of fluid ports to air volume" annotation (Evaluate=true,Dialog(enable=useFluidPorts,connectorSizing=true,group="Air exchange",tab="Gains and Losses"));
  parameter Integer nPeople(min=0) "Max. number of people present" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  parameter Real pElLights(unit="W/m2",min=0) "Max. electrical power consumed by lighting" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  parameter Modelica.SIunits.Efficiency effLights "(1-effLights)*power ist treated as heat gain" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  parameter Real pElDevices(unit="W/m2",min=0) "Max. electrical Power consumed by devices" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  parameter Modelica.SIunits.Efficiency effDevices "(1-effDevices)*power is treated as heat gain" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  // Air change
  parameter Real acrInf(unit="1/h") "Air change rate by infiltration through constructions from the outside" annotation(Dialog(group="Air exchange",tab="Gains and Losses"));
  parameter Real acrVent(unit="1/h") "Air change rate by ventilation" annotation(Dialog(group="Air exchange",tab="Gains and Losses"));
  parameter Integer nMinPplVent=0 "Minimum number of people to start ventilation" annotation(Dialog(group="Air exchange",tab="Gains and Losses"));
  // Heating and cooling
  parameter Boolean calcUseHeatDem=true "Set to false if heating system is modelled from outside" annotation(Dialog(group="Heating and Cooling",tab="Control"));
  parameter Real k=roo.V*1.3*1005 if calcUseHeatDem
                                             "Gain constant - adjust to your building" annotation(Dialog(enable=calcUseHeatDem,group="Heating and Cooling",tab="Control"));
  parameter SI.Temperature Tmin_occ=293.15 "Minimum allowed temperature (people present)" annotation(Dialog(enable=calcUseHeatDem,group="Heating and Cooling",tab="Control"));
  parameter SI.Temperature Tmin_nocc=289.15 "Minimum allowed temperature (no people present)" annotation(Dialog(enable=calcUseHeatDem,group="Heating and Cooling",tab="Control"));
  parameter SI.Temperature Tmax_occ=298.15 "Maximum allowed temperature (people present)" annotation(Dialog(enable=calcUseHeatDem,group="Heating and Cooling",tab="Control"));
  parameter SI.Temperature Tmax_nocc=303.15 "Maximum allowed temperature (no people present)" annotation(Dialog(enable=calcUseHeatDem,group="Heating and Cooling",tab="Control"));
  parameter SI.HeatFlowRate pMaxHeat=Modelica.Constants.inf annotation (Dialog(
      tab="Control",
      group="Heating and Cooling",
      enable=calcUseHeatDem));
  parameter SI.HeatFlowRate pMaxCool=Modelica.Constants.inf annotation (Dialog(
      tab="Control",
      group="Heating and Cooling",
      enable=calcUseHeatDem));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer qThermalBridge=0.03 "Heat flow rate of thermal bridges of the envelope" annotation(Dialog(group="Heat Gains",tab="Gains and Losses"));
  parameter Types.Weekday lastDayOfWorkWeek=Types.Weekday.Saturday "Day after which schedule is changed" annotation (Dialog(
      choicesAllMatching=true,
      group="General",
      tab="Gains and Losses"));
  parameter Real schedules[:,:]=[0, 0, 0.05, 0, 0.05; 6, 0.1, 0.1, 0.05, 0.05; 7, 0.2, 0.3, 0.05, 0.05; 8, 0.95, 0.3, 0.05, 0.05; 9, 0.95, 0.9, 0.05, 0.05; 13, 0.95, 0.5, 0.05, 0.05; 17, 0.3, 0.5, 0.05, 0.05; 18, 0.1, 0.3, 0, 0.05; 19, 0.1, 0.3, 0, 0.05; 20, 0.1, 0.2, 0, 0.05; 22, 0, 0.1, 0, 0.05; 23, 0, 0.05, 0, 0.05; 24, 0, 0.05, 0, 0.05] "Column 0: hour of the day, C1: share of occupancy and C2: lighting (weekday); C3: Share of occupancy and C4: lighting (weekend)" annotation(Dialog(group="General",tab="Gains and Losses"));
  // Energy Efficiency Measures
  parameter Boolean hasEnclosure=false "Set to true if the volume of a room within the thermal zone ist to be substracted from the zone volume" annotation(Dialog(group="General",tab="Energy Efficiency Measures"));
  parameter Modelica.SIunits.Volume enclosureVolume=0 "Volume to subtract from the zone volume A*h" annotation(Dialog(enable=hasEnclosure,group="General",tab="Energy Efficiency Measures"));
                                                                        // only thermal bridges to the outside are considered
  replaceable package MediumTABS = Buildings.Media.Water constrainedby Modelica.Media.Interfaces.PartialMedium "To use TABS (all of the same kind) set nConTABS in the Constructions tab >0" annotation (__Dymola_choicesAllMatching=true, Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType sysTypTABS=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Ceiling_Wall_or_Capillary if nConTABS>0 "Radiant system type" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter SI.Distance disPipTABS=0.02 if nConTABS>0 "Pipe distance" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter Buildings.Fluid.Data.Pipes.Generic pipeTABS if nConTABS>0 "Record for pipe geometry and material" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter Integer nCirTABS=1 if nConTABS>0 "Number of parallel circuits" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter Integer iLayPipTABS=1 if nConTABS>0 "Number of the interface layer (counted from outside) in which the pipes are located" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter SI.Length lengthTABS if nConTABS>0 "Length of the pipe of a single circuit" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  parameter SI.MassFlowRate m_flow_nominalTABS=1 if nConTABS>0 "Nominal mass flow rate of all circuits combined" annotation(Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"));
  // Constructions
  parameter Integer nConBou(min=0) "Number of constructions with another boundary condition" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Integer nGroundFloor(min=0,max=nConBou)=1 "Number of floor constructions (subset of nConBou) connected to the ground <= nConBou" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Integer nSurBou(min=0)
    "Number of surfaces that connect to constructions that are modeled outside of this room" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Integer nConTABS(min=0,max=nSurBou)=0 "Number of thermally activated constructions (subset of nSurBou) <= nSurBou" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Buildings.ThermalZones.Detailed.BaseClasses.ParameterConstruction datConBou[max(1,nConBou)](
    each A=0,
    each layers = roo.dummyCon,
    each til=0,
    each azi=0) "Data for construction boundary (start with ground floor if present)"
    annotation (HideResult=true,Dialog(enable=nConBouExt>0,group="Components",tab="Constructions"));
  parameter Buildings.ThermalZones.Detailed.BaseClasses.OpaqueSurface surBou[max(1,nSurBou)](
    each A=0,
    each til=0)
    "Record for data of surfaces whose heat conduction is modeled outside of this room (start with TABS if present)"
    annotation (HideResult=true,Dialog(enable=nSurBou>0,group="Components",tab="Constructions"));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic layersTABS(nLay(min=2)) if nConTABS>0 "Definition of the construction, which must have at least two material layers" annotation (
    Dialog(enable=nConTABS>0,group="TABS",tab="Energy Efficiency Measures"),
    choicesAllMatching=true,
    Placement(transformation(extent={{-64,-98},{-50,-84}})));

  // --- Models ---
  // Thermal zones
  ThermalZones.MixedAir roo(redeclare package Medium = MediumAir,
    T_start=T_start,                                             nPorts=nFPorts+nIntFPorts,mSenFac=thMassFactor,nConBou=nConBou,nSurBou=nSurBou,nConPar=0,datConBou=datConBou,surBou=surBou,lat=latitude,AFlo=if hasRectBaseArea then length*width else baseArea,hRoo=hall_surHeight)
  annotation (Placement(transformation(extent={{36,-36},{78,4}})));

  // Boundary Conditions
  Buildings.HeatTransfer.Sources.PrescribedTemperature groundTemp[nGroundFloor] if nGroundFloor>0 "Boundary condition for construction" annotation (Placement(transformation(extent={{-5,-5},{5,5}}, origin={23,-71})));

  // Heating and cooling
 Controls.semi_idealHeater idealHeater_var(k=k,
    pMaxHeat=pMaxHeat,
    pMaxCool=pMaxCool) if
              calcUseHeatDem annotation (Placement(transformation(extent={{-34,-54},{-14,-34}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRoomAir "Room temperature" annotation (Placement(transformation(extent={{82,14},{94,26}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRad "Radiative room temperature" annotation (Placement(transformation(extent={{88,-10},{100,2}})));
  Modelica.SIunits.Heat heatingDemand(displayUnit="kWh");
  Modelica.SIunits.Heat coolingDemand(displayUnit="kWh");
  Modelica.Blocks.Math.Gain roomArea(k=1/roo.AFlo) annotation (Placement(transformation(extent={{-12,-8},{-6,-2}})));
  Modelica.Blocks.Math.Gain roomArea1(k=1/roo.AFlo) annotation (Placement(transformation(extent={{-12,-22},{-6,-16}})));
  Modelica.Blocks.Math.Add operativeTemperature(
    k1=0.5,
    k2=0.5,
    y(unit="K", displayUnit="degC")) annotation (Placement(transformation(extent={{92,4},{100,12}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor if calcUseHeatDem annotation (Placement(transformation(extent={{6,-48},{18,-36}})));
  Modelica.Blocks.Sources.RealExpression Tmin1(y=Tmin_occ)
                                                       annotation (Placement(transformation(extent={{-80,-58},{-68,-48}})));
  Modelica.Blocks.Sources.RealExpression Tmax1(y=Tmax_occ)
                                                       annotation (Placement(transformation(extent={{-78,-38},{-66,-28}})));

  // Outputs Kästchenlib
  Modelica.Blocks.Math.Add totUsefulHeatDemand if  calcUseHeatDem annotation (Placement(transformation(extent={{66,-76},{72,-70}})));
  Modelica.Blocks.Math.Max heatingLoad "Heating load required to cover useful heat demand" annotation (Placement(transformation(extent={{88,-70},{94,-64}})));
  Modelica.Blocks.Math.Min coolingLoad "Cooling load required to cover useful cool demand" annotation (Placement(transformation(extent={{90,-96},{96,-90}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(transformation(extent={{72,-86},{80,-80}})));
  Modelica.Blocks.Interfaces.RealOutput insideRoomTemperature(unit="K",displayUnit="degC") "Absolute air temperature inside as output signal" annotation (Placement(transformation(extent={{100,52},{124,76}}),
                         iconTransformation(extent={{100,52},{124,76}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_heat_ideal(unit="W",displayUnit="kW") "Heating load of building if useful heat demand is calculated" annotation (Placement(transformation(extent={{100,-76},{124,-52}}),
                         iconTransformation(extent={{100,-76},{124,-52}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_cool_ideal(unit="W",displayUnit="kW") "Cooling load of building if useful heat demand is calculated" annotation (Placement(transformation(extent={{100,-100},{124,-76}}),
                         iconTransformation(extent={{100,-100},{124,-76}})));
  Modelica.Blocks.Interfaces.RealOutput P_el(unit="W", displayUnit="kW") "Electrical load" annotation (Placement(transformation(extent={{100,-52},{124,-28}}), iconTransformation(extent={{100,-52},{124,-28}})));
  Modelica.Blocks.Interfaces.RealOutput operativeRoomTemperature(unit="K", displayUnit="degC") "operative temperature inside as output signal" annotation (Placement(transformation(extent={{100,40},{124,64}}), iconTransformation(extent={{100,28},{124,52}})));

  // Gains
  Modelica.Blocks.Math.MultiSum radGainTot(
    y(unit="W/m2"), nu=if useHeatInputRad then 6 else 5) "Total radiative heat gain"                 annotation (Placement(transformation(extent={{12,6},{20,14}})));
  Modelica.Blocks.Math.MultiSum convGainTot(
    y(unit="W/m2"), nu=if useHeatInputConv then 6 else 5) "Total convective heat gain"
                    annotation (Placement(transformation(extent={{12,-6},{20,2}})));
  Modelica.Blocks.Math.MultiSum latGainTot(y(unit="W/m2"), nu=1) "Total latent heat gain" annotation (Placement(transformation(extent={{12,-24},{20,-16}})));
  Modelica.Blocks.Math.MultiSum electricalPower(y(unit="W"), nu=2)
                                                             "Sums up the electrical power per base area of all devices"
                                                                annotation (Placement(transformation(extent={{90,-46},{96,-40}})));
  Modelica.Blocks.Sources.CombiTimeTable dayOfWeek(
    table=[0,0; 1,1; 2,2; 3,3; 4,4; 5,5; 6,6; 7,0],
    columns=2:size(dayOfWeek.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="d") = 86400) "Mo-Su -> 0-6" annotation (Placement(transformation(extent={{-86,72},{-78,80}})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(extent={{-72,70},{-66,76}})));
  Utilities.WeekDayToInt weekDayToInt(day=lastDayOfWorkWeek) annotation (Placement(transformation(extent={{-86,62},{-78,70}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=schedules,
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-86,50},{-78,58}})));
  Modelica.Blocks.Logical.Switch switchSchedLight annotation (Placement(transformation(extent={{-64,58},{-58,64}})));
  Modelica.Blocks.Logical.Switch
                    switchSchedPeople annotation (Placement(transformation(extent={{-64,48},{-58,54}})));
  InternalGains.Gain_elEq lights(
    shareRad=0.6,
    nominalPower=pElLights,
    efficiency=effLights)
                     annotation (Placement(transformation(extent={{-42,44},{-34,52}})));
  InternalGains.Gain_th_n people(
    shareRad=0.8,
    n=nPeople,
    nominalPower=75,
    area=roo.AFlo)
               annotation (Placement(transformation(extent={{-44,34},{-36,42}})));
  InternalGains.ThermalBridge thermalBridge(
    shareRad=0.5,
    nominalPower=qThermalBridge,
    floorArea=roo.AFlo,
    envelopeArea=envelopeArea)
    annotation (Placement(transformation(extent={{-42,58},{-34,66}})));
  InternalGains.Gain_elEq ElectronicDevices(
    shareRad=0.4,
    nominalPower=pElDevices,
    efficiency=effDevices)
                    annotation (Placement(transformation(extent={{-42,22},{-34,30}})));

  // Energy Efficiency Measures
  Buildings.Fluid.HeatExchangers.RadiantSlabs.ParallelCircuitsSlab sla[nConTABS](
    each allowFlowReversal=false,
    each sysTyp=sysTypTABS,
    each disPip=disPipTABS,
    each pipe=pipeTABS,
    each layers=layersTABS,
    each steadyStateInitial=false,
    each iLayPip=iLayPipTABS,
    each stateAtSurface_a=false,
    each stateAtSurface_b=false,
    redeclare each package Medium = MediumTABS,
    each energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    each massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    each nCir=nCirTABS,
    each m_flow_nominal=m_flow_nominalTABS,
    each length=lengthTABS,
    A=ATABS,
    each T_start=T_start,
    each T_a_start=T_start,
    each T_b_start=T_start) "thermally activated constructions" annotation (Placement(transformation(extent={{-82,-4},{-64,14}})));

  Modelica.Blocks.Logical.Switch T_room_min annotation (Placement(transformation(extent={{-56,-58},{-50,-52}})));
  Modelica.Blocks.Sources.RealExpression Tmin2(y=Tmin_nocc)
                                                       annotation (Placement(transformation(extent={{-80,-66},{-68,-56}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-78,-72},{-72,-66}})));
  Modelica.Blocks.Logical.Switch T_room_max1
                                            annotation (Placement(transformation(extent={{-56,-44},{-50,-38}})));
  Modelica.Blocks.Sources.RealExpression Tmax2(y=Tmax_nocc)
                                                       annotation (Placement(transformation(extent={{-78,-46},{-66,-36}})));
protected
  parameter Integer nIntFPorts=0 "Number of flow ports that are connected inside of the buildingModel";
  parameter Modelica.SIunits.Length hall_surHeight=if hasEnclosure then (roo.AFlo*zoneHeight-enclosureVolume)/roo.AFlo else zoneHeight "Surrogate height to subtract enclosure volume";
  replaceable package MediumAir = Buildings.Media.Air (T_default=T_start) constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for inside and outside air";
  parameter SI.Area ATABS[nConTABS]=surBou[1:nConTABS].A if nConTABS>0 "Surface area of radiant slab (all circuits combined)";

initial equation
  heatingDemand=0;
  coolingDemand=0;

equation
  // Connectors
  connect(heatPortAir, roo.heaPorAir) annotation (Line(points={{-87,101},{-28,101},{-28,4},{28,4},{28,-12},{32,-12},{32,-16},{55.95,-16}},color={191,0,0}));
  connect(heatPortRad, roo.heaPorRad) annotation (Line(points={{-47,101},{-44,101},{-44,-38},{32,-38},{32,-40},{56,-40},{56,-24},{55.95,-24},{55.95,-19.8}},
                                                                                                                                          color={191,0,0}));
  for i in nIntFPorts+1:roo.nPorts loop
    connect(fPorts[i-nIntFPorts], roo.ports[i]) annotation (Line(points={{-104,34},{-58,34},{-58,8},{8,8},{8,-10},{30,-10},{30,-26},{41.25,-26}}, color={0,127,255}));
  end for;
  if nConTABS>0 then
    connect(portTABS_a, sla.port_a) annotation (Line(points={{-110,-14},{-86,-14},{-86,5},{-82,5}},
                                                                                                  color={0,127,255}));
    connect(sla.port_b, portTABS_b) annotation (Line(points={{-64,5},{-58,5},{-58,-32},{-78,-32},{-78,-88},{-74,-88},{-74,-110}}, color={0,127,255}));
    connect(sla[:].surf_a, surf_conTABS[1:nConTABS]) annotation (Line(points={{-69.4,14},{-68,14},{-68,18},{26,18},{26,-64},{62,-64},{62,-90},{44,-90},{44,-104}}, color={191,0,0}));
    connect(roo.surf_surBou[1:nConTABS], sla[:].surf_b) annotation (Line(points={{53.01,-30},{62,-30},{62,-56},{40,-56},{40,-62},{-80,-62},{-80,-8},{-69.4,-8},{-69.4,-4}},color={191,0,0}));
  end if;
  // Boundary Conditions
  connect(groundTemp[:].port, roo.surf_conBou[1:nGroundFloor]) annotation (Line(points={{28,-71},{40,-71},{40,-56},{62,-56},{62,-36},{63.3,-36},{63.3,-32}},                  color={191,0,0}));
  connect(roo.surf_surBou, surf_surBou) annotation (Line(points={{53.01,-30},{52,-30},{52,-88},{22,-88},{22,-104}}, color={191,0,0}));

  connect(roo.surf_conBou[nGroundFloor+1:nConBou], surf_conBou[1:nConBou-nGroundFloor]) annotation (Line(points={{63.3,-32},{62,-32},{62,-90},{66,-90},{66,-104}}, color={191,0,0}));
  /*
  for i in 1:nConBou-nGroundFloor loop
    connect(roo.surf_conBou[nGroundFloor+i], surf_conBou[i]) annotation (Line(points={{63.3,-32},{62,-32},{62,-90},{66,-90},{66,-104}}, color={191,0,0}));
  end for;
  */
  // Heating and cooling
  connect(TRoomAir.T, insideRoomTemperature) annotation (Line(points={{94,20},{96,20},{96,64},{112,64}},
                                                                                                    color={0,0,127}));
  connect(roomArea.y, radGainTot.u[2]) annotation (Line(points={{-5.7,-5},{2,-5},{2,6},{6,6},{6,10},{12,10}},   color={0,0,127}));
  connect(roomArea1.y, convGainTot.u[2]) annotation (Line(points={{-5.7,-19},{2,-19},{2,-10},{6,-10},{6,-2},{12,-2}},
                                                                                                                   color={0,0,127}));
  connect(roo.heaPorRad, TRad.port) annotation (Line(points={{55.95,-19.8},{54,-19.8},{54,-24},{56,-24},{56,-38},{84,-38},{84,-14},{88,-14},{88,-4}}, color={191,0,0}));
  connect(TRoomAir.T, operativeTemperature.u1) annotation (Line(points={{94,20},{94,24},{96,24},{96,30},{76,30},{76,14},{78,14},{78,10.4},{91.2,10.4}}, color={0,0,127}));
  connect(TRad.T, operativeTemperature.u2) annotation (Line(points={{100,-4},{104,-4},{104,-14},{88,-14},{88,-12},{84,-12},{84,5.6},{91.2,5.6}}, color={0,0,127}));
  connect(zero.y, totUsefulHeatDemand.u2) annotation (Line(points={{80.4,-83},{60,-83},{60,-74.8},{65.4,-74.8}}, color={0,0,127}));
  if calcUseHeatDem then
    connect(heatFlowSensor.port_b, roo.heaPorAir) annotation (Line(points={{18,-42},{22,-42},{22,-28},{28,-28},{28,-12},{32,-12},{32,-16},{55.95,-16}},
                                                                                                                    color={191,0,0}));
    connect(heatFlowSensor.Q_flow, totUsefulHeatDemand.u1) annotation (Line(points={{12,-48},{38,-48},{38,-71.2},{65.4,-71.2}},                   color={0,0,127}));
    connect(totUsefulHeatDemand.y, heatingLoad.u1) annotation (Line(points={{72.3,-73},{78,-73},{78,-65.2},{87.4,-65.2}}, color={0,0,127}));
    connect(totUsefulHeatDemand.y, coolingLoad.u1) annotation (Line(points={{72.3,-73},{80,-73},{80,-74},{88,-74},{88,-88},{89.4,-88},{89.4,-91.2}}, color={0,0,127}));
  end if;
  connect(zero.y, heatingLoad.u2) annotation (Line(points={{80.4,-83},{86,-83},{86,-72},{82,-72},{82,-68.8},{87.4,-68.8}}, color={0,0,127}));
  connect(zero.y, coolingLoad.u2) annotation (Line(points={{80.4,-83},{84,-83},{84,-94.8},{89.4,-94.8}}, color={0,0,127}));
  if not calcUseHeatDem then
    connect(zero.y, heatingLoad.u1) annotation (Line(points={{80.4,-83},{6,-83},{6,-38},{64,-38},{64,-65.2},{87.4,-65.2}},         color={0,0,127}));
    connect(zero.y, coolingLoad.u1) annotation (Line(points={{80.4,-83},{6,-83},{6,-38},{64,-38},{64,-64},{80,-64},{80,-74},{89.4,-74},{89.4,-91.2}},         color={0,0,127}));
  end if;
  connect(idealHeater_var.port_b, heatFlowSensor.port_a) annotation (Line(points={{-13.6,-44},{0,-44},{0,-42},{6,-42}},
                                                                                                        color={191,0,0}));
  connect(TRoomAir.T, idealHeater_var.actTemperature) annotation (Line(points={{94,20},{94,24},{96,24},{96,30},{76,30},{76,20},{-36,20},{-36,-38.6}},         color={0,0,127}));
  connect(operativeTemperature.y, operativeRoomTemperature) annotation (Line(points={{100.4,8},{106,8},{106,36},{94,36},{94,52},{112,52}}, color={0,0,127}));
  // Outputs Kästchenlib
  connect(heatingLoad.y, Q_flow_heat_ideal) annotation (Line(points={{94.3,-67},{94.3,-64},{112,-64}}, color={0,0,127}));
  connect(coolingLoad.y, Q_flow_cool_ideal) annotation (Line(points={{96.3,-93},{112,-88}}, color={0,0,127}));
  der(heatingDemand)=Q_flow_heat_ideal;
  der(coolingDemand)=Q_flow_cool_ideal;
  connect(roo.heaPorAir, TRoomAir.port) annotation (Line(points={{55.95,-16},{32,-16},{32,-12},{28,-12},{28,4},{30,4},{30,12},{76,12},{76,20},{82,20}},
                                                   color={191,0,0}));
  connect(electricalPower.y, P_el) annotation (Line(points={{96.51,-43},{96,-43},{96,-40},{112,-40}}, color={0,0,127}));
  // Gains and Losses
  connect(radGainTot.y, roo.qGai_flow[1]) annotation (Line(points={{20.68,10},{28,10},{28,6},{26,6},{26,-9.06667},{34.32,-9.06667}},
                                                                                                                                color={0,0,127}));
  connect(convGainTot.y, roo.qGai_flow[2]) annotation (Line(points={{20.68,-2},{24,-2},{24,-8},{34.32,-8}},   color={0,0,127}));
  connect(latGainTot.y, roo.qGai_flow[3]) annotation (Line(points={{20.68,-20},{24,-20},{24,-6.93333},{34.32,-6.93333}}, color={0,0,127}));
  connect(Q_gainRad, radGainTot.u[6]) annotation (Line(points={{-115,-53},{-88,-53},{-88,-6},{-64,-6},{-64,-2},{-60,-2},{-60,10},{12,10}},
                                                                                                                                   color={0,0,127}));
  connect(Q_gainConv, convGainTot.u[6]) annotation (Line(points={{-115,-83},{14,-83},{14,-22},{8,-22},{8,-2},{12,-2}},     color={0,0,127}));
  connect(switchSchedLight.y, lights.schedule) annotation (Line(points={{-57.7,61},{-50,61},{-50,48},{-42.8,48}}, color={0,0,127}));
  connect(switchSchedPeople.y, people.schedule) annotation (Line(points={{-57.7,51},{-56,51},{-56,38},{-44.8,38}},                   color={0,0,127}));
  connect(zero.y, latGainTot.u[1]) annotation (Line(points={{80.4,-83},{8,-83},{8,-22},{6,-22},{6,-28},{12,-28},{12,-20}}, color={0,0,127}));
  connect(lights.Qth_conv, convGainTot.u[4]) annotation (Line(points={{-33.28,46.8},{-20,46.8},{-20,-2},{12,-2}},                            color={0,0,127}));
  connect(lights.Qth_rad, radGainTot.u[4]) annotation (Line(points={{-33.28,45.2},{-33.28,38},{-14,38},{-14,36},{-18,36},{-18,10},{12,10}},color={0,0,127}));
  connect(people.Qth_conv, convGainTot.u[3]) annotation (Line(points={{-35.28,36.8},{-20,36.8},{-20,-2},{12,-2}},                        color={0,0,127}));
  connect(people.Qth_rad, radGainTot.u[3]) annotation (Line(points={{-35.28,35.2},{-30,35.2},{-30,-12},{-20,-12},{-20,10},{12,10}},    color={0,0,127}));
  connect(lights.Pel, electricalPower.u[1]) annotation (Line(points={{-33.24,49.96},{-14.62,49.96},{-14.62,-41.95},{90,-41.95}},
                                                                                                                           color={0,0,127}));
  connect(TRoomAir.T, thermalBridge.Tinside) annotation (Line(points={{94,20},{94,24},{96,24},{96,30},{76,30},{76,20},{-50,20},{-50,76},{-40.36,76},{-40.36,66.04}}, color={0,0,127}));
  connect(thermalBridge.Qth_conv, convGainTot.u[5]) annotation (Line(points={{-33.28,60.8},{-4,60.8},{-4,0},{6,0},{6,-2},{12,-2}}, color={0,0,127}));
  connect(thermalBridge.Qth_rad, radGainTot.u[5]) annotation (Line(points={{-33.28,59.2},{-33.28,38.4},{12,38.4},{12,10}}, color={0,0,127}));
  connect(switchSchedLight.y,lights. schedule) annotation (Line(points={{-57.7,61},{-46,61},{-46,48},{-42.8,48}}, color={0,0,127}));
  connect(switchSchedPeople.y,people. schedule) annotation (Line(points={{-57.7,51},{-52,51},{-52,38},{-44.8,38}},                   color={0,0,127}));
  connect(schedTable.y[1],switchSchedPeople. u1) annotation (Line(points={{-77.6,54},{-68,54},{-68,53.4},{-64.6,53.4}}, color={0,0,127}));
  connect(schedTable.y[2],switchSchedLight. u1) annotation (Line(points={{-77.6,54},{-68,54},{-68,63.4},{-64.6,63.4}}, color={0,0,127}));
  connect(schedTable.y[3],switchSchedPeople. u3) annotation (Line(points={{-77.6,54},{-64,54},{-64,44},{-64.6,44},{-64.6,48.6}}, color={0,0,127}));
  connect(schedTable.y[4],switchSchedLight. u3) annotation (Line(points={{-77.6,54},{-68,54},{-68,58.6},{-64.6,58.6}}, color={0,0,127}));
  connect(dayOfWeek.y[1],less. u1) annotation (Line(points={{-77.6,76},{-74,76},{-74,73},{-72.6,73}}, color={0,0,127}));
  connect(weekDayToInt.y,less. u2) annotation (Line(points={{-77.6,66},{-72.6,66},{-72.6,70.6}}, color={0,0,127}));
  connect(less.y,switchSchedLight. u2) annotation (Line(points={{-65.7,73},{-58,73},{-58,68},{-64,68},{-64,61},{-64.6,61}}, color={255,0,255}));
  connect(less.y,switchSchedPeople. u2) annotation (Line(points={{-65.7,73},{-58,73},{-58,68},{-64,68},{-64,51},{-64.6,51}}, color={255,0,255}));
  connect(ElectronicDevices.schedule,switchSchedPeople. y) annotation (Line(points={{-42.8,26},{-57.7,26},{-57.7,51}}, color={0,0,127}));
  connect(ElectronicDevices.Pel, electricalPower.u[2]) annotation (Line(points={{-33.24,27.96},{28.38,27.96},{28.38,-44.05},{90,-44.05}}, color={0,0,127}));
  connect(ElectronicDevices.Qth_conv, convGainTot.u[1]) annotation (Line(points={{-33.28,24.8},{-20,24.8},{-20,0},{6,0},{6,-2},{12,-2}},             color={0,0,127}));
  connect(ElectronicDevices.Qth_rad, radGainTot.u[1]) annotation (Line(points={{-33.28,23.2},{-10.64,23.2},{-10.64,10},{12,10}},   color={0,0,127}));
  // Infiltration and ventilation
  connect(Tmin1.y, T_room_min.u1) annotation (Line(points={{-67.4,-53},{-59.1,-53},{-59.1,-52.6},{-56.6,-52.6}}, color={0,0,127}));
  connect(Tmin2.y, T_room_min.u3) annotation (Line(points={{-67.4,-61},{-56.6,-61},{-56.6,-57.4}}, color={0,0,127}));
  connect(greaterThreshold.y, T_room_min.u2) annotation (Line(points={{-71.7,-69},{-62,-69},{-62,-55},{-56.6,-55}}, color={255,0,255}));
  connect(Tmax1.y, T_room_max1.u1) annotation (Line(points={{-65.4,-33},{-60,-33},{-60,-38.6},{-56.6,-38.6}}, color={0,0,127}));
  connect(greaterThreshold.y, T_room_max1.u2) annotation (Line(points={{-71.7,-69},{-62,-69},{-62,-41},{-56.6,-41}}, color={255,0,255}));
  connect(Tmax2.y, T_room_max1.u3) annotation (Line(points={{-65.4,-41},{-60,-41},{-60,-43.4},{-56.6,-43.4}}, color={0,0,127}));
  connect(idealHeater_var.T_max, T_room_max1.y) annotation (Line(points={{-36,-46.8},{-44,-46.8},{-44,-41},{-49.7,-41}}, color={0,0,127}));
  connect(idealHeater_var.T_min, T_room_min.y) annotation (Line(points={{-36,-51.2},{-44,-51.2},{-44,-55},{-49.7,-55}}, color={0,0,127}));
  connect(greaterThreshold.u, switchSchedPeople.y) annotation (Line(points={{-78.6,-69},{-84,-69},{-84,6},{-86,6},{-86,38},{-56,38},{-56,48},{-57.7,48},{-57.7,51}}, color={0,0,127}));
  for i in 1:nGroundFloor loop
    connect(T_ground, groundTemp[i].T) annotation (Line(points={{-11,-115},{-11,-78},{10,-78},{10,-71},{17,-71}}, color={0,0,127}));
  end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true),graphics={
                                        Text(
        extent={{-100,132},{98,114}},
        lineColor={0,0,255},
          textString="%name",
          horizontalAlignment=TextAlignment.Left)}),                                            Diagram(coordinateSystem(preserveAspectRatio=true)),
    Documentation(info="<html>
<p><b>Connectors</b>: The user can decide which connectors should be generated, depending on technical building equipment etc.</p>
<p><b>Geometry</b>: Length and width (inner dimensions) of the cuboid zone are only defined for convenience. You can still define as many walls per orientation as you like.</p>
<p><b>Components</b>: The constructions need to be specified according to the Buildings library (see <a href=\"modelica://ThermalIntegrationLib/../Buildings 8.0.0/ThermalZones/Detailed/UsersGuide.mo\">Buildings.ThermalZones.Detailed.UsersGuide.MixedAir</a>). Exeption: <b>nConTABS</b> is used to specify the number of thermally activated building systems (TABS). It is a subset of <b>nSurBou </b>but no connector will be generated as the TABS are modelled within the thermal zone. Specify the properties in the <i>Energy Efficiency Measures</i> tab. <b>surBou</b> still needs to be filled with data. See <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/ThermalZones/Examples/Modelling/roomInRoom_internTABS.mo\">Examples/Modelling/roomInRoom_internTABS</a>. In order to model different kinds of TABS they need to be connceted from the outside (see <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/ThermalZones/Examples/Modelling/roomInRoom_externTABS.mo\">Examples/Modelling/roomInRoom_externTABS</a>).</p><p>Please note that <b>each zone needs its own construction records</b> dragged into the model! A construction record cannot be used for two different thermal zones!</p>
<p><b>Heat gains</b>: You may specify heat gains based on <b>schedules</b> here or connect external models to the <b>heatPortAir</b> and <b>heatPortRad</b>.</p>
<p><b>Air exchange</b>: You may specify air exchange with the outside here or connect some air conditioning device to the fluid ports.</p>
<p><b>Heating and cooling</b>: Set <b>calcUseHeatDem</b> to true if you wish to calculate the useful heating and cooling demand without modelling the heating/cooling system. Note that the set temperatures refer to the air temperature.</p>
<p><b>Energy Efficiency Measures</b>: If there is a thermal zone present inside your thermal zone (like an enclosure) you may use <b>enclosureVolume</b> to substract its volume from your zone volume. Don&apos;t forget to substract the base area from the floor area of the zone in <b>datConBou</b>.</p>
<p>The TABS are based on the buildings model <a href=\"modelica://ThermalIntegrationLib/../Buildings 8.0.0/Fluid/HeatExchangers/RadiantSlabs/ParallelCircuitsSlab.mo\">Buildings.Fluid.HeatExchangers.RadiantSlabs.ParallelCircuits</a>. The fluid connectors are conditionally generated and need to be connected from the outside.</p>
</html>"));
end PartialBuildingModel;
