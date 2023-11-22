within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.ProcessingProgramms;
package BaseClasses
  record ProcessingProgramm_base
    parameter Real ProcessingProgramm_chronological_log[:,2];
    parameter Real ProcessingProgramm[:,11];
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end ProcessingProgramm_base;
end BaseClasses;
