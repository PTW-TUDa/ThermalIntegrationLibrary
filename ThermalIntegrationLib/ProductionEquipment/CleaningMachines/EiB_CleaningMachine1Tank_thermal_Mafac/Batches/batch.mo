within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.Batches;
model batch
  parameter Modelica.Units.SI.Mass m_batch "Mass of batch";
  parameter Modelica.Units.SI.HeatCapacity c_batch "Heat capacity of batch";
  parameter Modelica.Units.SI.Mass m_rack "Mass of batching rack";
  parameter Modelica.Units.SI.HeatCapacity c_rack "Heat capacity of batching rack";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor_batch(C=(c_batch*m_batch) + (c_rack*m_rack), T(
      start=293.15,
      fixed=true,
      displayUnit="degC")) annotation (Placement(transformation(
        extent={{-28,-28},{28,28}},
        rotation=270,
        origin={58,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.06)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.BooleanInput new_batch annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));

equation
   when edge(new_batch) then
    reinit(heatCapacitor_batch.T, 293.15);
   end when;
  connect(port_tank, thermalConductor.port_a)
    annotation (Line(points={{-100,0},{-40,0}}, color={191,0,0}));
  connect(thermalConductor.port_b, heatCapacitor_batch.port) annotation (Line(points={{-20,0},{30,8.65974e-15}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                                graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None),
        Polygon(
          points={{0,40},{-82,10},{0,-20},{80,10},{0,40}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-40,-6},{-80,-20},{0,-50},{80,-20},{38,-6}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-80,100},{80,40}},
          lineColor={0,0,0},
          textString="batch"),
        Line(
          points={{-40,-36},{-80,-50},{0,-80},{80,-50},{38,-36}},
          color={0,0,0},
          thickness=0.5)}),      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end batch;
