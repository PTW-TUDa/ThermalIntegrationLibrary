within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TankHeating;
model washingController
  parameter Integer wState1 = 5,
                    wState2 = 7;
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput out annotation (Placement(transformation(extent={{100,-20},{140,
            20}}), iconTransformation(extent={{100,-20},{140,20}})));
equation
  if state >= wState1 and state <= wState2 then
    out = true; // washing on
  else
    out = false; // washing off
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          textString="washing
controller")}),           Diagram(coordinateSystem(preserveAspectRatio=false)));
end washingController;
