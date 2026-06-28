 
# Direct-Mapped Cache Controller

A **Verilog HDL** implementation of a **Direct-Mapped Cache Controller** that interfaces between the CPU and main memory. The controller reduces memory access latency through efficient cache management using hit/miss detection, address decoding, FSM-based control, and automatic cache updates. The design was developed and verified using **Xilinx Vivado**.

---

## Features

* Direct-Mapped Cache Architecture
* 4 Cache Lines
* 2-Byte Cache Block Size
* 8-Bit Addressing
* Address Decoder (Tag, Index & Offset)
* Cache Memory with Valid Bit
* Hit/Miss Detection
* FSM-Based Cache Controller
* Automatic Cache Update on Cache Miss
* Direct-Mapped Cache Replacement
* Main Memory Interface
* Functional Verification using Verilog Testbench
* RTL Simulation in Xilinx Vivado

---

## Cache Specifications

| Parameter          | Value                      |
| ------------------ | -------------------------- |
| Cache Mapping      | Direct Mapped              |
| Address Width      | 8 Bits                     |
| Data Width         | 8 Bits                     |
| Cache Lines        | 4                          |
| Block Size         | 2 Bytes                    |
| Total Cache Size   | 8 Bytes                    |
| Replacement Policy | Direct Mapping (Overwrite) |
| Valid Bit          | Supported                  |
| Design Language    | Verilog HDL                |
| Simulation Tool    | Xilinx Vivado              |

---

## Working

1. The CPU sends an 8-bit address to the cache controller.
2. The address is divided into **Tag**, **Index**, and **Offset**.
3. The controller compares the incoming tag with the stored tag of the selected cache line.
4. If the tag matches and the valid bit is set, a **Cache Hit** occurs and the requested data is returned directly from the cache.
5. If the tag does not match or the valid bit is cleared, a **Cache Miss** occurs.
6. On a cache miss, the required 2-byte block is fetched from the main memory, the cache line is updated, and the requested data is returned to the CPU.
7. If another memory block maps to the same cache index, the existing cache line is overwritten, demonstrating the behavior of a Direct-Mapped Cache.

---

## Finite State Machine (FSM)

```text
IDLE
  │
COMPARE_TAG
 ├── Hit  ─► CACHE_READ ─► DATA_RETURN
 └── Miss ─► MEMORY_READ ─► CACHE_UPDATE ─► DATA_RETURN
```

---

## Verification

The design has been verified through a comprehensive Verilog testbench covering the following scenarios:

* Reset Verification
* Cache Miss Detection
* Cache Hit Detection
* Cache Block Update
* Cache Replacement
* Conflict Miss
* Cache Full Condition
* Valid Bit Verification
* Main Memory Read Operation

---

## Future Enhancements

* Write-Back Cache Policy
* Write-Allocate Support
* Dirty Bit Implementation
* Set-Associative Cache
* LRU Replacement Policy
* Performance Statistics (Hit Rate & Miss Rate)
* Configurable Cache Parameters

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* Vivado Simulator

---

## Author

**Pothuganti Divya Sree**

**Roll No.: 124EC0063**

B.Tech – Electronics and Communication Engineering

National Institute of Technology Rourkela

---

 
