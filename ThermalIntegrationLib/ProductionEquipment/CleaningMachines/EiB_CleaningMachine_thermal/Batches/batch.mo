within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.Batches;
model batch
  extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=c_batch*m_batch, T(
      start=298.15,
      fixed=true,
      displayUnit="degC"))          annotation (Placement(transformation(
        extent={{-28,-28},{28,28}},
        rotation=270,
        origin={48,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.1)
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
  Modelica.Blocks.Interfaces.BooleanInput new_batch annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
   when edge(new_batch) then
     reinit(heatCapacitor.T, 298.15);
   end when;
  connect(thermalConductor.port_b, heatCapacitor.port)
    annotation (Line(points={{-6,0},{20,8.88178e-15}}, color={191,0,0}));
  connect(port_tank, thermalConductor.port_a)
    annotation (Line(points={{-100,0},{-26,0}}, color={191,0,0}));
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
