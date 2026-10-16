# Async FIFO simulation runner (Windows PowerShell, Icarus Verilog)
#
# Usage:
#   .\run_sim.ps1                          # correct design, wclk half-period 3 ns, rclk half-period 7 ns
#   .\run_sim.ps1 -WHalf 5 -RHalf 6        # different clock ratio
#   .\run_sim.ps1 -Bug 1                   # fault-injection run (Bug = 1, 2, 3 or 4)
#
# Output: PASS/FAIL summary in the terminal, waveform in fifo.vcd (open with: gtkwave fifo.vcd)

param(
    [ValidateSet(0, 1, 2, 3, 4)] [int]$Bug = 0,
    [double]$WHalf = 3,
    [double]$RHalf = 7
)

$top   = "rtl/fifo.v"
$wrptr = "rtl/wrptr.v"
$rptr  = "rtl/rptr.v"

switch ($Bug) {
    1 { $wrptr = "bugs/wrptr_bug1.v" }
    2 { $rptr  = "bugs/rptr_bug2.v" }
    3 { $top   = "bugs/fifo_bug3.v" }
    4 { $top   = "bugs/fifo_bug4.v" }
}

$files = @("tb/tb_fifo.v", $top, $wrptr, $rptr,
           "rtl/dpram.v", "rtl/sync2.v", "rtl/width.v", "rtl/rst_bridge.v")

Write-Host "Bug=$Bug  WHALF=$WHalf ns  RHALF=$RHalf ns"
iverilog -P testbench.WHALF=$WHalf -P testbench.RHALF=$RHalf -o sim @files
if ($LASTEXITCODE -eq 0) { vvp sim }
