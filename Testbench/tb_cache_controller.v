 `timescale 1ns / 1ps

module tb_cache_controller;
reg clk;
reg reset;
reg cpu_read;
reg [7:0] cpu_address;

wire [7:0] cpu_data;
wire ready;
wire hit;
wire miss;

cache_controller DUT
(
    .clk(clk),
    .reset(reset),

    .cpu_read(cpu_read),
    .cpu_address(cpu_address),

    .cpu_data(cpu_data),

    .ready(ready),
    .hit(hit),
    .miss(miss)
);

initial
    clk = 0;

always #5 clk = ~clk;

initial
begin
 $monitor(
"Time=%0t | State=%0d | Addr=%d | Tag=%b | Index=%b | Offset=%b | Data=%d | Hit=%b | Miss=%b | Ready=%b | MemRead=%b | CacheWrite=%b | CacheTag=%b | Valid=%b | Block=%h",

$time,

DUT.FSM.state,

cpu_address,

DUT.tag,
DUT.index,
DUT.offset,

cpu_data,

hit,
miss,
ready,

DUT.memory_read_enable,
DUT.cache_write_enable,

DUT.cache_tag,
DUT.cache_valid,

DUT.block_data

);

end

initial
begin
reset = 1;
cpu_read = 0;
cpu_address = 0;
#20;
reset = 0;
#20;
// TEST-1
// Address 20
// Expected : MISS
$display("\n ");
$display("TEST-1 : ADDRESS = 20 (MISS)");
 
cpu_address = 8'd20;
cpu_read = 1;
#10;
cpu_read = 0;
#60;
 
// TEST-2
// Address 21
// Expected : HIT
$display("\n ");
$display("TEST-2 : ADDRESS = 21 (HIT)");
 
cpu_address = 8'd21;
cpu_read = 1;
#10;
cpu_read = 0;
#60;

// TEST-3
// Address 20 Again
// Expected : HIT
$display("\n ");
$display("TEST-3 : ADDRESS = 20 AGAIN (HIT)");
 
cpu_address = 8'd20;
cpu_read = 1;
#10;
cpu_read = 0;
#60;

// TEST-4
// Address 100
// Expected : MISS

$display("\n ");
$display("TEST-4 : ADDRESS = 100 (MISS)");
 
cpu_address = 8'd100;
cpu_read = 1;
#10;
cpu_read = 0;
#60;

// TEST-5
// Address 100 Again
// Expected : HIT

$display("\n ");
$display("TEST-5 : ADDRESS = 100 AGAIN (HIT)");
 
cpu_address = 8'd100;
cpu_read = 1;
#10;
cpu_read = 0;
#60;

// TEST-6
// Address 20 Again
// Expected : MISS
// (because 100 replaced it)

$display("\n ");
$display("TEST-6 : ADDRESS = 20 AGAIN (MISS)");
 
cpu_address = 8'd20;
cpu_read = 1;
#10;
cpu_read = 0;
#60;
 
// TEST-7 : Fill Remaining Cache Lines
 
$display("\n ");
$display("TEST-7 : FILL CACHE");
cpu_address = 8'd0;      // Index = 00
cpu_read = 1;
#10;
cpu_read = 0;
#60;
cpu_address = 8'd2;      // Index = 01
cpu_read = 1;
#10;
cpu_read = 0;
#60;
cpu_address = 8'd6;      // Index = 11
cpu_read = 1;
#10;
cpu_read = 0;
#60;
 
// TEST-8 : Replace Address 0 with Address 32
$display("\n ");
$display("TEST-8 : ADDRESS = 32 (REPLACEMENT)");
cpu_address = 8'd32;
cpu_read = 1;
#10;
cpu_read = 0;
#60;
#80;
$finish;
end
endmodule