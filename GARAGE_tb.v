`timescale 1ns/1ps
module GARAGE_tb();
  
reg Activate,Up_MAX,Dn_MAX;
reg CLK,RST;
wire UP_M,DN_M;

Garage dut(
.Activate(Activate),
.Up_MAX(Up_MAX),
.Dn_MAX(Dn_MAX),
.CLK(CLK),
.RST(RST),
.UP_M(UP_M),
.DN_M(DN_M)
);

localparam T=20;
always 
begin
  CLK=1'b0;
  #(T/2)
  CLK=1'b1;
  #(T/2);
end

initial
begin
  $dumpfile("GARAGE.vcd");
  $dumpvars;
  initialize;
  RESET;
  Up;
  #(3*T);
  UP_I;
  #(T);
  Down;
  #(3*T);
  DOWN_I;
  #(T);
  $stop;
  end


task initialize;
  begin
    Activate=0;
    Up_MAX=0;
    Dn_MAX=0;
    
  end
endtask


task RESET;
  begin
    RST=0;
    #2
    RST=1;
  end
endtask


task Up;
  begin
Up_MAX=0;
Dn_MAX=1;
Activate=1;
#(T);
Activate=0;
Dn_MAX=0;
end
endtask


task Down;
  begin
Up_MAX=1;
Dn_MAX=0;
Activate=1;
#(T);
Activate=0;
Up_MAX=0;
end
endtask


task UP_I;
  begin
    Up_MAX=1;
  end
endtask


task DOWN_I;
  begin
   Dn_MAX=1;
  end
endtask


endmodule
