within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model enclosure_TABSwithDetailledPiping
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Temperature T_init_insideBox(displayUnit="degC") = 273.15+14 "Initial inside temperature of the enclosure";
  parameter Real alpha_outs = 15; // 6.6
  parameter Real alpha_ins = 35; // 6.6
  InternalGains.Gain_th_per_area machineType1(
    shareRad=0.12,
    nominalPower=1/enclosure.roo.AFlo,
    schedule)                                                                           annotation (Placement(transformation(extent={{-74,-54},{-66,-46}})));
  ThermalZones.Enclosure enclosure(
    useHeatPortAir=true,
    useFluidPorts=true,
    acrInf=5,
    qThermalBridge=0.1,
    calcUseHeatDem=false,
    length=2,
    width=0.56,
    zoneHeight=1,
    nConBou=6,
    nSurBou=4,
    nGroundFloor=0,
    datConBou(
      name={"Floor","Ceiling","A","B","C","D"},
      layers={enclosureFloor,enclosureWalls,enclosureWalls,enclosureWalls,enclosureWalls,duconArm},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={0,0,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.E},
      A={enclosure.length*enclosure.width,enclosure.length*enclosure.width,enclosure.length*enclosure.zoneHeight - (0.182*0.75),enclosure.length*enclosure.zoneHeight - (0.182*0.75),enclosure.width*enclosure.zoneHeight - (0.4*0.75),enclosure.width*enclosure.zoneHeight - (0.75*0.6)},
      each stateAtSurface_a=false,
      each T_b_start=T_init_insideBox,
      each T_a_start=T_init_insideBox),
    surBou(
      A={(0.182*0.75),(0.182*0.75),(0.4*0.75),(0.4*0.6)},
      each absIR=0.93,
      each absSol=0.9,
      each til=Buildings.Types.Tilt.Wall),
    nFPorts=1,
    roo(T_start=T_init_insideBox, linearizeRadiation=false))
                                   "Room model" annotation (Placement(transformation(extent={{14,38},{44,68}})));
  Modelica.Blocks.Sources.CombiTimeTable q_Heizmatte(
    tableOnFile=true,
    table=[0,0; 1,1; 2.5,0; 6,0],
    tableName="q",
    fileName=Modelica.Utilities.Files.loadResource("C:\\Users\\Xenia Kirschstein\\Documents\\Projekte\\EiB\\TP5\\Dymola\\langerVersuch\\validationTAB_q.csv"),
    columns=2:size(q_Heizmatte.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale(displayUnit="h") = 3600,
    offset={0},
    startTime(displayUnit="h") = 0,
    y(unit="W"),
    shiftTime(displayUnit="h") = -53510.4)
                 annotation (Placement(transformation(extent={{-96,-38},{-86,-28}})));
  Buildings.Fluid.HeatExchangers.RadiantSlabs.ParallelCircuitsSlab  sla1[enclosure.nSurBou](
    each allowFlowReversal=false,
    each sysTyp=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Ceiling_Wall_or_Capillary,
    each disPip=10/1000,
    each pipe=datPip,
    each layers=enclosureWalls,
    each steadyStateInitial=false,
    each iLayPip=enclosureWalls.nLay - 1,
    each T_a_start=T_init_insideBox - 1,
    each T_b_start=T_init_insideBox - 1,
    each stateAtSurface_a=false,
    each stateAtSurface_b=true,
    redeclare each package Medium = Buildings.Media.Water,
    each energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    each massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    each T_start=T_init_insideBox - 1,
    each dp_nominal=4E5,
    each linearizeFlowResistance=false,
    nCir={72,72,40,40},
    length={enclosure.length,enclosure.length,0.6,0.75},
    m_flow_nominal={0.2*1000/3600/3,0.2*1000/3600/3,0.2*1000/3600/6,0.2*1000/3600/6},
    A={(0.182*0.75),(0.182*0.75),(0.4*0.6),(0.4*0.75)},
    each heatTransfer=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.HeatTransfer.EpsilonNTU,
    each show_T=true)                                                                                annotation (Placement(transformation(extent={{18,-40},{36,-22}})));
  parameter HeatTransfer.Data.Pipes.PEX_DN_3dot35                                                  datPip(dOut=3.35E-3, dIn=2.35E-3,
    roughness=0.001,
    d=910,
    k=0.23)                                                                                               annotation (Placement(transformation(extent={{80,70},{92,82}})));
  Buildings.Fluid.Sources.MassFlowSource_T waterSource(
    redeclare package Medium = Buildings.Media.Water,
    use_m_flow_in=true,
    use_T_in=true,
    T=283.15,
    nPorts=1)                   annotation (Placement(transformation(extent={{-76,-10},{-60,6}})));
  Buildings.Fluid.Sources.Boundary_pT waterSink(redeclare package Medium = Buildings.Media.Water,
    T(displayUnit="K") = 293.15,                                                                  nPorts=1)                   annotation (Placement(transformation(extent={{98,-30},{82,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemperature annotation (Placement(transformation(extent={{-62,82},{-50,94}})));
  parameter HeatTransfer.Data.OpaqueConstructions.EnclosureFloorValidation enclosureFloor(
    material={HeatTransfer.Data.Solids.OSB(x=0.012),HeatTransfer.Data.Solids.BuildingProtectionSheet(x=0.006),HeatTransfer.Data.Solids.VacuumInsulation(x=0.02),HeatTransfer.Data.Solids.BuildingProtectionSheet(x=0.006),HeatTransfer.Data.Solids.DUCON(x=0.05)},
                                                                                          absIR_a=0.93, absIR_b=0.93)
                                                                                          annotation (Placement(transformation(extent={{66,84},{78,96}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Ducon_VacuumInsulated    enclosureWalls(
    material={HeatTransfer.Data.Solids.VacuumInsulation(x=0.02),HeatTransfer.Data.Solids.DUCON(x=0.025),HeatTransfer.Data.Solids.DUCON(x=0.025)},
    absIR_a=0.93,
    absIR_b=0.93)                                                                         annotation (Placement(transformation(extent={{80,84},{92,96}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Buildings.Media.Air,
    use_T_in=true,                                                                           nPorts=1)                annotation (Placement(transformation(extent={{-92,52},{-76,68}})));
  Modelica.Blocks.Sources.CombiTimeTable inletTemperature(
    tableOnFile=true,
    tableName="TVL",
    fileName=Modelica.Utilities.Files.loadResource("C:\\Users\\Xenia Kirschstein\\Documents\\Projekte\\EiB\\TP5\\Dymola\\langerVersuch\\validationTAB_TVL.csv"),
    columns=2:size(inletTemperature.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale(displayUnit="h") = 3600,
    offset={273.15},
    startTime(displayUnit="h"),
    shiftTime(displayUnit="h") = -53510.4,
    y(unit="K", displayUnit="degC"))     annotation (Placement(transformation(extent={{-96,-6},{-86,4}})));
  Modelica.Blocks.Sources.CombiTimeTable vflow(
    tableOnFile=true,
    table=[0,0; 1,1; 2.5,0; 6,0],
    tableName="vflow",
    fileName=Modelica.Utilities.Files.loadResource("C:\\Users\\Xenia Kirschstein\\Documents\\Projekte\\EiB\\TP5\\Dymola\\langerVersuch\\validationTAB_vflow.csv"),
    columns=2:size(vflow.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale(displayUnit="h") = 3600,
    offset={0},
    startTime(displayUnit="h") = 0,
    shiftTime(displayUnit="h") = -53510.4)
     annotation (Placement(transformation(extent={{-96,16},{-86,26}})));
  Buildings.Fluid.Sensors.DensityTwoPort senDen(redeclare each package Medium = Buildings.Media.Water, each m_flow_nominal=0.2*1000/3600) annotation (Placement(transformation(extent={{-54,-28},{-44,-18}})));
  Modelica.Blocks.Sources.RealExpression timeUnit(y=1/(3600)) "per h to per s (per circuit)" annotation (Placement(transformation(extent={{-96,34},{-84,46}})));
  Modelica.Blocks.Math.MultiProduct vflowToMflow(nu=3) "m3 per h to kg per s (per unit)" annotation (Placement(transformation(extent={{-74,22},{-66,30}})));
  Modelica.Blocks.Sources.CombiTimeTable Tamb(
    tableOnFile=true,
    tableName="Tamb",
    fileName=Modelica.Utilities.Files.loadResource("C:\\Users\\Xenia Kirschstein\\Documents\\Projekte\\EiB\\TP5\\Dymola\\langerVersuch\\validationTAB_Tamb.csv"),
    columns=2:size(Tamb.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale(displayUnit="h") = 3600,
    offset={273.15},
    startTime(displayUnit="h"),
    shiftTime(displayUnit="h") = -53510.4,
    y(unit="K",displayUnit="degC")) annotation (Placement(transformation(extent={{-96,74},{-86,84}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe34(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=1.9,
    isCircular=true,
    diameter=(10 - 2*1.1)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=T_init_insideBox - 1,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
                                                                    "Connection between slab3 and slab4" annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={25,-89})));
  inner Modelica.Fluid.System system(T_ambient=295.05)
                                     annotation (Placement(transformation(extent={{-96,-98},{-86,-88}})));
  Modelica.Fluid.Fittings.MultiPort multiPort(redeclare package Medium = Buildings.Media.Water,
                                              nPorts_b=enclosure.nSurBou-1) annotation (Placement(transformation(extent={{52,-28},{48,-18}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort returnTemperature(redeclare package Medium = Buildings.Media.Water)
                                                              annotation (Placement(transformation(extent={{84,4},{98,16}})));
  Modelica.Fluid.Fittings.MultiPort multiPort2(redeclare package Medium = Buildings.Media.Water, nPorts_b=enclosure.nSurBou-1)
                                                                            annotation (Placement(transformation(extent={{6,-36},{10,-26}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TVLinTABS(redeclare package Medium = Buildings.Media.Water) annotation (Placement(transformation(extent={{-16,-56},{-2,-44}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic duconArm(nLay=2, material={HeatTransfer.Data.Solids.Armaflex(x=0.032),HeatTransfer.Data.Solids.DUCON(x=0.05)},
    absIR_a=0.93,
    absIR_b=0.93)                                                                                                                                                                  annotation (Placement(transformation(extent={{52,84},{64,96}})));
  parameter HeatTransfer.Data.Pipes.PEX_DN_3dot35                                                  datPip1(dOut=20/1000,
    dIn=16/1000,
    roughness=datPip.roughness,
    d=datPip.d,
    k=datPip.k)                                                                                           annotation (Placement(transformation(extent={{66,70},{78,82}})));
  Buildings.HeatTransfer.Convection.Interior conInt[enclosure.nSurBou](
    A=sla1.A,
    each conMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
    each hFixed=0,
    each til=Buildings.Types.Tilt.Wall) annotation (Placement(transformation(extent={{0,14},{-12,26}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeVL1(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=1.9,
    isCircular=true,
    diameter=(10 - 2*1.1)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=T_init_insideBox - 1,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer) "insulated supply pipe wall A"
                                                                                                   annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={3,-69})));
  Modelica.Fluid.Pipes.DynamicPipe pipeRL2(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=1.9,
    isCircular=true,
    diameter=(10 - 2*1.1)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=T_init_insideBox - 1,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
                                                                    "insulated return pipe wall B" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={43,-59})));
  Modelica.Fluid.Pipes.DynamicPipe pipeRL4(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=1.9,
    isCircular=true,
    diameter=(10 - 2*1.1)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=T_init_insideBox - 1,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
                                                                    "insulated return pipe wall D" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={43,-75})));
  Buildings.HeatTransfer.Convection.Interior conInt1[enclosure.nConBou](
    A=enclosure.datConBou.A,
    each conMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
    til=enclosure.datConBou.til)   annotation (Placement(transformation(extent={{0,30},{-12,42}})));
  Modelica.Fluid.Pipes.DynamicPipe aluverbundrohrVL(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=5,
    isCircular=true,
    diameter=(16 - 2*2)/1000,
    roughness=datPip.roughness,
    T_start=T_init_insideBox,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
                                                                                                        annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-29,-47})));
  Modelica.Fluid.Pipes.DynamicPipe aluverbundrohrRL(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=5,
    isCircular=true,
    diameter=(16 - 2*2)/1000,
    roughness=datPip.roughness,
    T_start=system.T_ambient,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer)
                                                                                                        annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={71,-25})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TVLinPipe(redeclare package Medium = Buildings.Media.Water) annotation (Placement(transformation(extent={{-42,-12},{-30,0}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort returnTemperatureInPipe(redeclare package Medium = Buildings.Media.Water) annotation (Placement(transformation(extent={{64,-60},{78,-48}})));
  Modelica.Blocks.Sources.CombiTimeTable measuredReturnTemperature(
    tableOnFile=true,
    tableName="mTRL",
    fileName=Modelica.Utilities.Files.loadResource("C:\\Users\\Xenia Kirschstein\\Documents\\Projekte\\EiB\\TP5\\Dymola\\langerVersuch\\Measured_TRL_enclosure_TABS_Validation.csv"),
    columns=2:size(measuredReturnTemperature.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale(displayUnit="h") = 3600,
    offset={273.15},
    startTime(displayUnit="h"),
    shiftTime(displayUnit="h") = -53510.4,
    y(unit="K", displayUnit="degC")) annotation (Placement(transformation(extent={{106,-46},{116,-36}})));
  Modelica.Fluid.Pipes.DynamicPipe pipeVLHalle(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=5,
    isCircular=true,
    diameter=(16 - 2*2)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=T_init_insideBox,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer) "insulated supply pipe wall A" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-49,-47})));
  Modelica.Fluid.Pipes.DynamicPipe pipeRLHalle(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    nParallel=1,
    length=5,
    isCircular=true,
    diameter=(16 - 2*2)/1000,
    roughness=datPip.roughness,
    p_a_start=sla1[3].p_start,
    p_b_start=sla1[4].p_start,
    T_start=293.15,
    nNodes=10,
    use_HeatTransfer=true,
    redeclare model HeatTransfer = Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer) "insulated supply pipe wall A" annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={71,-5})));
  Buildings.Fluid.Sensors.DensityTwoPort senDen1(redeclare each package Medium = Buildings.Media.Water, each m_flow_nominal=0.2*1000/3600)
                                                                                                                                          annotation (Placement(transformation(extent={{58,18},{68,28}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature T_pipeHalle annotation (Placement(transformation(extent={{-78,-70},{-66,-58}})));
  Modelica.Blocks.Sources.RealExpression T_Halle(y=293.15) annotation (Placement(transformation(extent={{-96,-70},{-84,-58}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=4) annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={209,89})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=enclosure.nSurBou)
                                                                              annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={205,127})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=enclosure.nConBou)
                                                                             annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={203,107})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector8(m=aluverbundrohrVL.nNodes)
                                                                              annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=0,
        origin={207,77})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector10(m=pipeVLHalle.nNodes)
                                                                               annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=0,
        origin={187,77})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor5[aluverbundrohrVL.nNodes](each R=Modelica.Math.log(16/12)/(0.43*2*Modelica.Constants.pi*aluverbundrohrVL.length/aluverbundrohrVL.nNodes) + 1/(alpha_outs*aluverbundrohrVL.length/aluverbundrohrVL.nNodes*Modelica.Constants.pi*aluverbundrohrVL.diameter)) annotation (Placement(transformation(extent={{144,54},{152,62}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector7(m=4) annotation (Placement(transformation(extent={{138,100},{152,86}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector3(m=pipe34.nNodes)
                                                                              annotation (Placement(transformation(extent={{158,100},{172,86}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector11(m=pipeRLHalle.nNodes)
                                                                               annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=0,
        origin={185,127})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor7[pipeRLHalle.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRLHalle.length/pipeRLHalle.nNodes) + Modelica.Math.log(42/10)/(0.0372*Modelica.Constants.pi*pipeRLHalle.length) + 1/(alpha_ins*pipeRLHalle.length/pipeRLHalle.nNodes*Modelica.Constants.pi*pipeRLHalle.diameter)) annotation (Placement(transformation(extent={{180,110},{188,118}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector9(m=aluverbundrohrVL.nNodes)
                                                                              annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=0,
        origin={133,89})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor4[aluverbundrohrRL.nNodes](each R=Modelica.Math.log(16/12)/(0.43*2*Modelica.Constants.pi*aluverbundrohrRL.length/aluverbundrohrRL.nNodes) + 1/(alpha_outs*aluverbundrohrRL.length/aluverbundrohrRL.nNodes*Modelica.Constants.pi*aluverbundrohrRL.diameter)) annotation (Placement(transformation(extent={{132,68},{140,76}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor6[pipeVLHalle.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeVLHalle.length/pipeVLHalle.nNodes) + Modelica.Math.log(42/10)/(0.0372*Modelica.Constants.pi*pipeVLHalle.length) + 1/(alpha_ins*pipeVLHalle.length/pipeVLHalle.nNodes*Modelica.Constants.pi*pipeVLHalle.diameter)) annotation (Placement(transformation(extent={{164,68},{172,76}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector4(m=pipeVL1.nNodes)
                                                                              annotation (Placement(transformation(extent={{142,80},{156,66}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1[pipeVL1.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeVL1.length/pipeVL1.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeVL1.length) + 1/(alpha_ins*pipeVL1.length/pipeVL1.nNodes*Modelica.Constants.pi*pipeVL1.diameter)) annotation (Placement(transformation(extent={{148,126},{156,134}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector12(m=2) annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=90,
        origin={131,129})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2[pipeRL2.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRL2.length/pipeRL2.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeRL2.length) + 1/(alpha_ins*pipeRL2.length/pipeRL2.nNodes*Modelica.Constants.pi*pipeRL2.diameter)) annotation (Placement(transformation(extent={{164,124},{172,132}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector5(m=pipeRL2.nNodes)
                                                                              annotation (Placement(transformation(extent={{180,100},{194,86}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector6(m=pipeRL4.nNodes)
                                                                              annotation (Placement(transformation(extent={{158,118},{172,104}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor3[pipeRL4.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRL4.length/pipeRL4.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeRL4.length) + 1/(alpha_ins*pipeRL4.length/pipeRL4.nNodes*Modelica.Constants.pi*pipeRL4.diameter)) annotation (Placement(transformation(extent={{144,102},{152,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor[pipe34.nNodes](each R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipe34.length/pipe34.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipe34.length) + 1/(alpha_ins*pipe34.length/pipe34.nNodes*Modelica.Constants.pi*pipe34.diameter)) annotation (Placement(transformation(extent={{132,102},{140,110}})));
equation
  connect(machineType1.Qth_conv, enclosure.Q_gainConv) annotation (Line(points={{-65.28,-51.2},{-19.64,-51.2},{-19.64,40.55},{11.75,40.55}},
                                                                                                                                          color={0,0,127}));
  connect(machineType1.Qth_rad, enclosure.Q_gainRad) annotation (Line(points={{-65.28,-52.8},{-18,-52.8},{-18,-12},{4,-12},{4,50},{11.75,50},{11.75,45.05}},
                                                                                                                                color={0,0,127}));
  connect(q_Heizmatte.y[1], machineType1.schedule) annotation (Line(points={{-85.5,-33},{-85.5,-50},{-74.8,-50}},
                                                                                                      color={0,0,127}));
  connect(bou1.ports[1], enclosure.fPorts[1]) annotation (Line(points={{-76,60},{12.5,60.5}},                                                       color={0,127,255}));
  connect(sla1.surf_b, enclosure.surf_surBou) annotation (Line(points={{30.6,-40},{40,-40},{40,30},{34.1,30},{34.1,36.5}},                     color={191,0,0}));
  connect(timeUnit.y, vflowToMflow.u[1]) annotation (Line(points={{-83.4,40},{-74,40},{-74,27.8667}},   color={0,0,127}));
  connect(vflow.y[1], vflowToMflow.u[3]) annotation (Line(points={{-85.5,21},{-74,21},{-74,24.1333}},   color={0,0,127}));
  connect(senDen.d, vflowToMflow.u[2]) annotation (Line(points={{-49,-17.5},{-49,26},{-74,26}},                                         color={0,0,127}));
  connect(Tamb.y[1], enclosure.ventilationTemperature) annotation (Line(points={{-85.5,79},{46,79},{46,74},{29,74},{29,70.4}},                   color={0,0,127}));
  connect(sla1[3].port_b, pipe34.port_a) annotation (Line(points={{36,-31},{30,-31},{30,-80},{34,-80},{34,-89},{30,-89}},
                                                                                                        color={0,127,255}));
  connect(pipe34.port_b, sla1[4].port_a) annotation (Line(points={{20,-89},{18,-89},{18,-84},{16,-84},{16,-68},{18,-68},{18,-31}},
                                                                                                              color={0,127,255}));
  connect(sla1[1].port_b, multiPort.ports_b[1]) annotation (Line(points={{36,-31},{48,-31},{48,-23}},        color={0,127,255}));
  //connect(sla1[2].port_b, multiPort.ports_b[2]) annotation (Line(points={{26,-47},{48,-47},{48,1}},          color={0,127,255}));
  //connect(sla1[4].port_b, multiPort.ports_b[3]) annotation (Line(points={{26,-47},{48,-47},{48,1}},          color={0,127,255}));
  connect(returnTemperature.port_b, waterSink.ports[1]) annotation (Line(points={{98,10},{98,-8},{82,-8},{82,-22}},    color={0,127,255}));
  //connect(multiPort2.ports_b[1], sla1[1].port_a) annotation (Line(points={{-2,-1},{2,-1},{2,-47},{8,-47}},              color={0,127,255}));
  connect(multiPort2.ports_b[1], pipeVL1.port_a) annotation (Line(points={{10,-31},{10,-60},{-6,-60},{-6,-69},{-2,-69}},color={0,127,255}));
  connect(multiPort2.ports_b[2], sla1[2].port_a) annotation (Line(points={{10,-31},{10,-48},{18,-48},{18,-31}},         color={0,127,255}));
  connect(multiPort2.ports_b[3], sla1[3].port_a) annotation (Line(points={{10,-31},{10,-48},{18,-48},{18,-31}},         color={0,127,255}));
  connect(waterSource.ports[1], senDen.port_a) annotation (Line(points={{-60,-2},{-60,-23},{-54,-23}},            color={0,127,255}));
  connect(TVLinTABS.port_b, multiPort2.port_a) annotation (Line(points={{-2,-50},{2,-50},{2,-31},{6,-31}},                   color={0,127,255}));
  connect(vflowToMflow.y, waterSource.m_flow_in) annotation (Line(points={{-65.32,26},{-62,26},{-62,-12},{-76,-12},{-76,4.4},{-77.6,4.4}},     color={0,0,127}));
  connect(conInt.solid, sla1.surf_a) annotation (Line(points={{-4.44089e-16,20},{30.6,20},{30.6,-22}},                                                       color={191,0,0}));
  connect(Tamb.y[1], outsideTemperature.T) annotation (Line(points={{-85.5,79},{-68,79},{-68,88},{-63.2,88}},
                                                                                            color={0,0,127}));
  connect(Tamb.y[1], bou1.T_in) annotation (Line(points={{-85.5,79},{-80,79},{-80,94},{-98,94},{-98,63.2},{-93.6,63.2}}, color={0,0,127}));
  connect(Tamb.y[1], enclosure.infiltrationTemperature) annotation (Line(points={{-85.5,79},{-76,79},{-76,98},{46,98},{46,74},{35,74},{35,70.4}}, color={0,0,127}));
  connect(pipeVL1.port_b, sla1[1].port_a) annotation (Line(points={{8,-69},{18,-69},{18,-31}}, color={0,127,255}));
  connect(sla1[2].port_b, pipeRL2.port_a) annotation (Line(points={{36,-31},{30,-31},{30,-59},{38,-59}}, color={0,127,255}));
  connect(sla1[4].port_b, pipeRL4.port_a) annotation (Line(points={{36,-31},{30,-31},{30,-75},{38,-75}}, color={0,127,255}));
  connect(pipeRL2.port_b,multiPort.ports_b[2]) annotation (Line(points={{48,-59},{52,-59},{52,-34},{48,-34},{48,-23}},
                                                                                                            color={0,127,255}));
  connect(pipeRL4.port_b,multiPort.ports_b[3]) annotation (Line(points={{48,-75},{52,-75},{52,-34},{48,-34},{48,-23}},
                                                                                                            color={0,127,255}));
  connect(enclosure.surf_conBou, conInt1.solid) annotation (Line(points={{41.3,36.5},{46,36.5},{46,28},{14,28},{14,36},{-4.44089e-16,36}},
                                                                                                                           color={191,0,0}));
  connect(senDen.port_b, TVLinPipe.port_a) annotation (Line(points={{-44,-23},{-38,-23},{-38,-10},{-46,-10},{-46,-6},{-42,-6}},
                                                                                                                          color={0,127,255}));
  connect(aluverbundrohrVL.port_b, TVLinTABS.port_a) annotation (Line(points={{-24,-47},{-16,-47},{-16,-50}},                          color={0,127,255}));
  connect(multiPort.port_a, returnTemperatureInPipe.port_a) annotation (Line(points={{52,-23},{58,-23},{58,-54},{64,-54}},               color={0,127,255}));
  connect(returnTemperatureInPipe.port_b, aluverbundrohrRL.port_a) annotation (Line(points={{78,-54},{82,-54},{82,-34},{60,-34},{60,-25},{66,-25}},               color={0,127,255}));
  connect(pipeVLHalle.port_a, TVLinPipe.port_b) annotation (Line(points={{-54,-47},{-58,-47},{-58,-2},{-26,-2},{-26,-6},{-30,-6}},                     color={0,127,255}));
  connect(pipeVLHalle.port_b, aluverbundrohrVL.port_a) annotation (Line(points={{-44,-47},{-34,-47}},                                       color={0,127,255}));
  connect(aluverbundrohrRL.port_b, pipeRLHalle.port_a) annotation (Line(points={{76,-25},{76,-14},{58,-14},{58,-5},{66,-5}},
                                                                                                                          color={0,127,255}));
  connect(pipeRLHalle.port_b, senDen1.port_a) annotation (Line(points={{76,-5},{80,-5},{80,32},{58,32},{58,23}},                         color={0,127,255}));
  connect(senDen1.port_b, returnTemperature.port_a) annotation (Line(points={{68,23},{82,23},{82,10},{84,10}},                 color={0,127,255}));
  connect(inletTemperature.y[1], waterSource.T_in) annotation (Line(points={{-85.5,-1},{-85.5,1.2},{-77.6,1.2}}, color={0,0,127}));
  connect(T_Halle.y, T_pipeHalle.T) annotation (Line(points={{-83.4,-64},{-79.2,-64}}, color={0,0,127}));
protected
  model Submodel1
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=4) annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-35,91})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1 annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-15,81})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-11,93})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector8 annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=0,
          origin={-35,49})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector10 annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=0,
          origin={-53,49})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor5[aluverbundrohrVL.nNodes](R=Modelica.Math.log(16/12)/(0.43*2*Modelica.Constants.pi*aluverbundrohrVL.length/aluverbundrohrVL.nNodes) + 1/(alpha_outs*aluverbundrohrVL.length/aluverbundrohrVL.nNodes*Modelica.Constants.pi*aluverbundrohrVL.diameter)) annotation (Placement(transformation(extent={{-40,28},{-32,36}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector7(m=4) annotation (Placement(transformation(extent={{38,70},{52,56}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector3 annotation (Placement(transformation(extent={{38,52},{52,38}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector11 annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=0,
          origin={93,61})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor7[pipeRLHalle.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRLHalle.length/pipeRLHalle.nNodes) + Modelica.Math.log(42/10)/(0.0372*Modelica.Constants.pi*pipeRLHalle.length) + 1/(alpha_ins*pipeRLHalle.length/pipeRLHalle.nNodes*Modelica.Constants.pi*pipeRLHalle.diameter)) annotation (Placement(transformation(extent={{68,26},{76,34}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector9 annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=0,
          origin={25,23})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor4[aluverbundrohrRL.nNodes](R=Modelica.Math.log(16/12)/(0.43*2*Modelica.Constants.pi*aluverbundrohrRL.length/aluverbundrohrRL.nNodes) + 1/(alpha_outs*aluverbundrohrRL.length/aluverbundrohrRL.nNodes*Modelica.Constants.pi*aluverbundrohrRL.diameter)) annotation (Placement(transformation(extent={{18,-2},{26,6}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor6[pipeVLHalle.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeVLHalle.length/pipeVLHalle.nNodes) + Modelica.Math.log(42/10)/(0.0372*Modelica.Constants.pi*pipeVLHalle.length) + 1/(alpha_ins*pipeVLHalle.length/pipeVLHalle.nNodes*Modelica.Constants.pi*pipeVLHalle.diameter)) annotation (Placement(transformation(extent={{-52,-20},{-44,-12}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector4 annotation (Placement(transformation(extent={{-14,-28},{0,-42}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1[pipeVL1.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeVL1.length/pipeVL1.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeVL1.length) + 1/(alpha_ins*pipeVL1.length/pipeVL1.nNodes*Modelica.Constants.pi*pipeVL1.diameter)) annotation (Placement(transformation(extent={{-22,-56},{-14,-48}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector12(m=2) annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-57,-65})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2[pipeRL2.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRL2.length/pipeRL2.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeRL2.length) + 1/(alpha_ins*pipeRL2.length/pipeRL2.nNodes*Modelica.Constants.pi*pipeRL2.diameter)) annotation (Placement(transformation(extent={{38,-56},{46,-48}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector5 annotation (Placement(transformation(extent={{34,-16},{48,-30}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector6 annotation (Placement(transformation(extent={{58,-28},{72,-42}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor3[pipeRL4.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipeRL4.length/pipeRL4.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipeRL4.length) + 1/(alpha_ins*pipeRL4.length/pipeRL4.nNodes*Modelica.Constants.pi*pipeRL4.diameter)) annotation (Placement(transformation(extent={{70,-74},{78,-66}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor[pipe34.nNodes](R=Modelica.Math.log(10/8.8)/(datPip.k*2*Modelica.Constants.pi*pipe34.length/pipe34.nNodes) + log(42/10)/(0.0372*Modelica.Constants.pi*pipe34.length) + 1/(alpha_ins*pipe34.length/pipe34.nNodes*Modelica.Constants.pi*pipe34.diameter)) annotation (Placement(transformation(extent={{12,-80},{20,-72}})));
    parameter Real alpha_outs = 15;
    parameter Real alpha_ins = 35;
    parameter HeatTransfer.Data.Pipes.PEX_DN_3dot35                                                  datPip(dOut=3.35E-3, dIn=2.35E-3,
      roughness=0.001,
      d=910,
      k=0.23)                                                                                               annotation (Placement(transformation(extent={{66,86},{78,98}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(rotation=0, extent={{-30,90},{-10,110}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1 annotation (Placement(transformation(rotation=0, extent={{-70,90},{-50,110}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(rotation=0, extent={{-110,-90},{-90,-70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1 annotation (Placement(transformation(rotation=0, extent={{-110,90},{-90,110}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b2 annotation (Placement(transformation(rotation=0, extent={{50,90},{70,110}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a2 annotation (Placement(transformation(rotation=0, extent={{-30,-110},{-10,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a3 annotation (Placement(transformation(rotation=0, extent={{-70,-110},{-50,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a4 annotation (Placement(transformation(rotation=0, extent={{30,-110},{50,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a5 annotation (Placement(transformation(rotation=0, extent={{70,-110},{90,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a6 annotation (Placement(transformation(rotation=0, extent={{90,-110},{110,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a7 annotation (Placement(transformation(rotation=0, extent={{-110,30},{-90,50}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a8 annotation (Placement(transformation(rotation=0, extent={{-110,-50},{-90,-30}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a9 annotation (Placement(transformation(rotation=0, extent={{90,30},{110,50}})));
  equation
    connect(thermalCollector1.port_b, thermalCollector2.port_a[1]) annotation (Line(points={{-22,81},{-22,80},{-27.475,80},{-27.475,91}},
                                                                                                                              color={191,0,0}));
    connect(thermalCollector.port_b, thermalCollector2.port_a[2]) annotation (Line(points={{-18,93},{-22,93},{-22,94},{-27.825,94},{-27.825,91}},
                                                                                                                             color={191,0,0}));
    connect(thermalCollector3.port_b, thermalCollector7.port_a[1]) annotation (Line(points={{45,52},{45,55.475}}, color={191,0,0}));
    connect(thermalCollector4.port_b, thermalCollector7.port_a[2]) annotation (Line(points={{-7,-28},{-7,-20},{32,-20},{32,32},{56,32},{56,55.825},{45,55.825}}, color={191,0,0}));
    connect(thermalCollector5.port_b, thermalCollector7.port_a[3]) annotation (Line(points={{41,-16},{40,-16},{40,32},{56,32},{56,56.175},{45,56.175}}, color={191,0,0}));
    connect(thermalCollector6.port_b, thermalCollector7.port_a[4]) annotation (Line(points={{65,-28},{64,-28},{64,-10},{40,-10},{40,32},{56,32},{56,56.525},{45,56.525}}, color={191,0,0}));
    connect(thermalCollector3.port_a, thermalResistor.port_b) annotation (Line(points={{45,38},{44,38},{44,6},{42,6},{42,-12},{52,-12},{52,-76},{20,-76}}, color={191,0,0}));
    connect(thermalResistor1.port_b, thermalCollector4.port_a) annotation (Line(points={{-14,-52},{-14,-46},{-7,-46},{-7,-42}}, color={191,0,0}));
    connect(thermalResistor2.port_b, thermalCollector5.port_a) annotation (Line(points={{46,-52},{50,-52},{50,-32},{46,-32},{46,-34},{41,-34},{41,-30}}, color={191,0,0}));
    connect(thermalResistor3.port_b, thermalCollector6.port_a) annotation (Line(points={{78,-70},{82,-70},{82,-62},{64,-62},{64,-46},{65,-46},{65,-42}}, color={191,0,0}));
    connect(thermalCollector8.port_b, thermalCollector2.port_a[3]) annotation (Line(points={{-35,56},{-35,72},{-28,72},{-28,80},{-26,80},{-26,88},{-28.175,88},{-28.175,91}},
                                                                                                                                                            color={191,0,0}));
    connect(thermalCollector9.port_b, thermalCollector2.port_a[4]) annotation (Line(points={{25,30},{2,30},{2,28},{-24,28},{-24,70},{-28,70},{-28,80},{-26,80},{-26,88},{-28.525,88},{-28.525,91}}, color={191,0,0}));
    connect(thermalResistor4.port_b, thermalCollector9.port_a) annotation (Line(points={{26,2},{30,2},{30,12},{14,12},{14,16},{25,16}}, color={191,0,0}));
    connect(thermalResistor5.port_b, thermalCollector8.port_a) annotation (Line(points={{-32,32},{-22,32},{-22,42},{-35,42}}, color={191,0,0}));
    connect(thermalResistor6.port_b, thermalCollector10.port_a) annotation (Line(points={{-44,-16},{-40,-16},{-40,10},{-53,10},{-53,42}}, color={191,0,0}));
    connect(thermalResistor7.port_b, thermalCollector11.port_a) annotation (Line(points={{76,30},{84,30},{84,46},{92,46},{92,50},{93,50},{93,54}}, color={191,0,0}));
    connect(thermalCollector10.port_b, thermalCollector12.port_a[1]) annotation (Line(points={{-53,56},{-68,56},{-68,36},{-78,36},{-78,30},{-104,30},{-104,-52},{-49.65,-52},{-49.65,-65}}, color={191,0,0}));
    connect(thermalCollector11.port_b, thermalCollector12.port_a[2]) annotation (Line(points={{93,68},{92,68},{92,72},{62,72},{62,22},{38,22},{38,-6},{22,-6},{22,-24},{-24,-24},{-24,-44},{-50,-44},{-50,-54},{-48,-54},{-48,-60},{-50.35,-60},{-50.35,-65}}, color={191,0,0}));
    connect(port_a, thermalCollector.port_a) annotation (Line(points={{-20,100},{-12,100},{-12,93},{-4,93}}, color={191,0,0}));
    connect(port_a1, thermalCollector1.port_a) annotation (Line(points={{-60,100},{-34,100},{-34,81},{-8,81}}, color={191,0,0}));
    connect(port_b, thermalCollector12.port_b) annotation (Line(points={{-100,-80},{-100,-65},{-64,-65}}, color={191,0,0}));
    connect(port_b1, thermalCollector2.port_b) annotation (Line(points={{-100,100},{-72,100},{-72,91},{-42,91}}, color={191,0,0}));
    connect(port_b2, thermalCollector7.port_b) annotation (Line(points={{60,100},{52,100},{52,70},{45,70}}, color={191,0,0}));
    connect(port_a2, thermalResistor.port_a) annotation (Line(points={{-20,-100},{-20,-76},{12,-76}}, color={127,0,0}));
    connect(port_a3, thermalResistor1.port_a) annotation (Line(points={{-60,-100},{-42,-100},{-42,-52},{-22,-52}}, color={127,0,0}));
    connect(port_a4, thermalResistor2.port_a) annotation (Line(points={{40,-100},{40,-100},{40,-52},{38,-52}}, color={191,0,0}));
    connect(port_a5, thermalResistor3.port_a) annotation (Line(points={{80,-100},{80,-72},{64,-72},{64,-70},{70,-70}}, color={127,0,0}));
    connect(port_a6, thermalResistor4.port_a) annotation (Line(points={{100,-100},{60,-100},{60,2},{18,2}}, color={191,0,0}));
    connect(port_a7, thermalResistor5.port_a) annotation (Line(points={{-100,40},{-70,40},{-70,32},{-40,32}}, color={191,0,0}));
    connect(port_a8, thermalResistor6.port_a) annotation (Line(points={{-100,-40},{-76,-40},{-76,-16},{-52,-16}}, color={127,0,0}));
    connect(port_a9, thermalResistor7.port_a) annotation (Line(points={{100,40},{84,40},{84,30},{68,30}}, color={127,0,0}));
  end Submodel1;
equation
  connect(thermalCollector1.port_b,thermalCollector2. port_a[1]) annotation (Line(points={{198,127},{198,108},{216.525,108},{216.525,89}},
                                                                                                                            color={191,0,0}));
  connect(thermalCollector.port_b,thermalCollector2. port_a[2]) annotation (Line(points={{196,107},{206.088,107},{206.088,89},{216.175,89}},
                                                                                                                           color={191,0,0}));
  connect(thermalCollector3.port_b,thermalCollector7. port_a[1]) annotation (Line(points={{165,100},{155,100},{155,85.475},{145,85.475}},
                                                                                                                color={191,0,0}));
  connect(thermalCollector4.port_b,thermalCollector7. port_a[2]) annotation (Line(points={{149,80},{134,80},{134,78},{124,78},{124,94},{128,94},{128,85.825},{145,85.825}},
                                                                                                                                                               color={191,0,0}));
  connect(thermalCollector5.port_b,thermalCollector7. port_a[3]) annotation (Line(points={{187,100},{166,100},{166,86.175},{145,86.175}},             color={191,0,0}));
  connect(thermalCollector6.port_b,thermalCollector7. port_a[4]) annotation (Line(points={{165,118},{140,118},{140,112},{126,112},{126,94},{128,94},{128,86.525},{145,86.525}},
                                                                                                                                                                        color={191,0,0}));
  connect(thermalCollector3.port_a,thermalResistor. port_b) annotation (Line(points={{165,86},{152.5,86},{152.5,106},{140,106}},                         color={191,0,0}));
  connect(thermalResistor1.port_b,thermalCollector4. port_a) annotation (Line(points={{156,130},{140,130},{140,112},{126,112},{126,98},{124,98},{124,66},{149,66}},
                                                                                                                              color={191,0,0}));
  connect(thermalResistor2.port_b,thermalCollector5. port_a) annotation (Line(points={{172,128},{140,128},{140,112},{126,112},{126,96},{138,96},{138,86},{187,86}},
                                                                                                                                                       color={191,0,0}));
  connect(thermalResistor3.port_b,thermalCollector6. port_a) annotation (Line(points={{152,106},{158.5,106},{158.5,104},{165,104}},                    color={191,0,0}));
  connect(thermalCollector8.port_b,thermalCollector2. port_a[3]) annotation (Line(points={{207,84},{207,84.5},{215.825,84.5},{215.825,89}},               color={191,0,0}));
  connect(thermalCollector9.port_b,thermalCollector2. port_a[4]) annotation (Line(points={{133,96},{174.238,96},{174.238,89},{215.475,89}},                                                       color={191,0,0}));
  connect(thermalResistor4.port_b,thermalCollector9. port_a) annotation (Line(points={{140,72},{88,72},{88,82},{133,82}},             color={191,0,0}));
  connect(thermalResistor5.port_b,thermalCollector8. port_a) annotation (Line(points={{152,58},{140,58},{140,70},{207,70}}, color={191,0,0}));
  connect(thermalResistor6.port_b,thermalCollector10. port_a) annotation (Line(points={{172,72},{187,70}},                              color={191,0,0}));
  connect(thermalResistor7.port_b,thermalCollector11. port_a) annotation (Line(points={{188,114},{140,114},{140,120},{185,120}},                 color={191,0,0}));
  connect(thermalCollector10.port_b,thermalCollector12. port_a[1]) annotation (Line(points={{187,84},{140,84},{140,129},{138.35,129}},                                                    color={191,0,0}));
  connect(thermalCollector11.port_b,thermalCollector12. port_a[2]) annotation (Line(points={{185,134},{137.65,134},{137.65,129}},                                                                                                                            color={191,0,0}));
  connect(thermalCollector2.port_b, outsideTemperature.port) annotation (Line(points={{202,89},{-42,88},{-50,88}},                                          color={191,0,0}));
  connect(conInt.fluid, thermalCollector1.port_a) annotation (Line(points={{-12,20},{-14,20},{-14,102},{124,102},{124,120},{140,120},{140,127},{212,127}},
                                                                                                                   color={191,0,0}));
  connect(conInt1.fluid, thermalCollector.port_a) annotation (Line(points={{-12,36},{99,36},{99,107},{210,107}},
                                                                                                       color={191,0,0}));
  connect(enclosure.heatPortAir, thermalCollector7.port_b) annotation (Line(points={{15.95,68.15},{12,68.15},{12,100},{145,100}},
                                                                                                                        color={191,0,0}));
  connect(pipeRLHalle.heatPorts, thermalResistor7.port_a) annotation (Line(points={{71.05,-2.8},{70,-2.8},{70,34},{140,34},{140,114},{180,114}},
                                                                                                                       color={127,0,0}));
  connect(thermalResistor4.port_a, aluverbundrohrRL.heatPorts) annotation (Line(points={{132,72},{71.05,72},{71.05,-22.8}},                    color={191,0,0}));
  connect(pipeRL4.heatPorts, thermalResistor3.port_a) annotation (Line(points={{43.05,-72.8},{124,-72.8},{124,106},{144,106}},
                                                                                                                   color={127,0,0}));
  connect(thermalResistor2.port_a, pipeRL2.heatPorts) annotation (Line(points={{164,128},{140,128},{140,112},{122,112},{122,30},{38,30},{38,-48},{42,-48},{42,-52},{43.05,-52},{43.05,-56.8}},
                                                                                                                   color={191,0,0}));
  connect(pipe34.heatPorts, thermalResistor.port_a) annotation (Line(points={{24.95,-86.8},{24.95,-82},{126,-82},{126,108},{124,108},{124,116},{132,116},{132,106}},
                                                                                                                  color={127,0,0}));
  connect(pipeVL1.heatPorts, thermalResistor1.port_a) annotation (Line(points={{3.05,-66.8},{-4,-66.8},{-4,-58},{32,-58},{32,-42},{60,-42},{60,-12},{104,-12},{104,112},{140,112},{140,130},{148,130}},
                                                                                                                   color={127,0,0}));
  connect(T_pipeHalle.port, thermalCollector12.port_b) annotation (Line(points={{-66,-64},{30,-64},{30,-66},{124,-66},{124,129}},               color={191,0,0}));
  connect(pipeVLHalle.heatPorts, thermalResistor6.port_a) annotation (Line(points={{-48.95,-44.8},{57.525,-44.8},{57.525,72},{164,72}},                   color={127,0,0}));
  connect(thermalResistor5.port_a, aluverbundrohrVL.heatPorts) annotation (Line(points={{144,58},{52,58},{52,32},{2,32},{2,6},{-20,6},{-20,-36},{-28.95,-36},{-28.95,-44.8}},
                                                                                                                                                    color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-98,114},{-22,102}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="The material layers start at surface a of the slab.
iLayers where the pipe is situated starts at surface a
as well (so count the layers from the outside).
")}),                                                                                                                                                             experiment(
      StopTime=19749.6,
      Interval=30,
      __Dymola_Algorithm="Cvode"));
end enclosure_TABSwithDetailledPiping;
