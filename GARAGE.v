module Garage(
input wire Activate,Up_MAX,Dn_MAX,
input wire CLK,RST,
output reg UP_M,DN_M
);



localparam IDLE=2'd0,
           Mv_Up=2'd1,
           Mv_DN=2'd2;
           
reg [1:0] Cu_State,Nxt_State;



/////transition state
always@(posedge CLK or negedge RST)
begin
  if(!RST)
    Cu_State<=IDLE;
  else
    Cu_State<=Nxt_State;
end
 
 
 
 
//////next state
always@(*)
begin
  case (Cu_State)
    IDLE:begin
          if(Activate==1)
            begin
              if(!Up_MAX && Dn_MAX)
                Nxt_State=Mv_Up;
              else 
                Nxt_State=Mv_DN;
            end
          else
            Nxt_State=IDLE;
          end
    Mv_Up:begin
           if(Up_MAX)
             Nxt_State=IDLE;
           else
             Nxt_State=Mv_Up;
          end 
    Mv_DN:begin
           if(Dn_MAX)
             Nxt_State=IDLE;
           else
             Nxt_State=Mv_DN;
          end
    default:Nxt_State=IDLE;
  endcase
end




/////////output logic
always@(*)
begin
  case (Cu_State)
    IDLE:begin
          UP_M=1'b0;
          DN_M=1'b0;
         end
         
    Mv_Up:begin
           UP_M=1'b1;
           DN_M=1'b0;
          end
          
    Mv_DN:begin
           UP_M=1'b0;
           DN_M=1'b1;
          end
      
    default:begin
             UP_M=1'b0;
             DN_M=1'b0;
            end
  endcase
end


endmodule
