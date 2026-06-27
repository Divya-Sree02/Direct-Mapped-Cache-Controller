 `timescale 1ns / 1ps

module tb_cache_controller;

//--------------------------------------------------
// Inputs
//--------------------------------------------------

reg clk;
reg reset;
reg cpu_read;
reg [7:0] cpu_address;

//--------------------------------------------------
// Outputs
//--------------------------------------------------

wire [7:0] cpu_data;
wire ready;
wire hit;
wire miss;

//--------------------------------------------------
// Instantiate Cache Controller
//--------------------------------------------------

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

//--------------------------------------------------
// Clock Generation
//--------------------------------------------------

initial
    clk = 0;

always #5 clk = ~clk;

//--------------------------------------------------
// Monitor
//--------------------------------------------------

initial
begin

$monitor(
"Time=%0t | State=%0d | Addr=%d | Data=%d | Hit=%b | Miss=%b | Ready=%b | MemRead=%b | CacheWrite=%b | Tag=%b | CacheTag=%b | Valid=%b | Block=%h",

$time,

DUT.FSM.state,

cpu_address,

cpu_data,

hit,
miss,
ready,

DUT.memory_read_enable,
DUT.cache_write_enable,

DUT.tag,
DUT.cache_tag,
DUT.cache_valid,

DUT.block_data

);

end

//--------------------------------------------------
// Test Sequence
//--------------------------------------------------

initial
begin

//--------------------------------------------------
// Reset
//--------------------------------------------------

reset = 1;
cpu_read = 0;
cpu_address = 0;

#20;

reset = 0;

#20;

/////////////////////////////////////////////////////
// TEST-1
// Address 20
// Expected : MISS
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-1 : ADDRESS = 20 (MISS)");
$display("==============================");

cpu_address = 8'd20;
cpu_read = 1;

#10;

cpu_read = 0;

#60;

/////////////////////////////////////////////////////
// TEST-2
// Address 21
// Expected : HIT
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-2 : ADDRESS = 21 (HIT)");
$display("==============================");

cpu_address = 8'd21;
cpu_read = 1;

#10;

cpu_read = 0;

#60;

/////////////////////////////////////////////////////
// TEST-3
// Address 20 Again
// Expected : HIT
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-3 : ADDRESS = 20 AGAIN (HIT)");
$display("==============================");

cpu_address = 8'd20;
cpu_read = 1;

#10;

cpu_read = 0;

#60;

/////////////////////////////////////////////////////
// TEST-4
// Address 100
// Expected : MISS
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-4 : ADDRESS = 100 (MISS)");
$display("==============================");

cpu_address = 8'd100;
cpu_read = 1;

#10;

cpu_read = 0;

#60;

/////////////////////////////////////////////////////
// TEST-5
// Address 100 Again
// Expected : HIT
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-5 : ADDRESS = 100 AGAIN (HIT)");
$display("==============================");

cpu_address = 8'd100;
cpu_read = 1;

#10;

cpu_read = 0;

#60;

/////////////////////////////////////////////////////
// TEST-6
// Address 20 Again
// Expected : MISS
// (because 100 replaced it)
//
/////////////////////////////////////////////////////

$display("\n==============================");
$display("TEST-6 : ADDRESS = 20 AGAIN (MISS)");
$display("==============================");

cpu_address = 8'd20;
cpu_read = 1;

#10;

cpu_read = 0;

#80;

$finish;

end

endmodule