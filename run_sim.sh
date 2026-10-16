#!/usr/bin/env sh
# Async FIFO simulation runner (Linux/macOS, Icarus Verilog)
#
# Usage:
#   ./run_sim.sh               # correct design, WHALF=3, RHALF=7
#   ./run_sim.sh 0 5 6         # correct design, WHALF=5, RHALF=6
#   ./run_sim.sh 1             # fault-injection run (bug 1..4)
#
# Arguments: [bug=0] [whalf=3] [rhalf=7]   (half-periods in ns)

BUG=${1:-0}; WHALF=${2:-3}; RHALF=${3:-7}
TOP=rtl/fifo.v; WRPTR=rtl/wrptr.v; RPTR=rtl/rptr.v

case "$BUG" in
  0) ;;
  1) WRPTR=bugs/wrptr_bug1.v ;;
  2) RPTR=bugs/rptr_bug2.v ;;
  3) TOP=bugs/fifo_bug3.v ;;
  4) TOP=bugs/fifo_bug4.v ;;
  *) echo "bug must be 0..4"; exit 1 ;;
esac

echo "Bug=$BUG  WHALF=$WHALF ns  RHALF=$RHALF ns"
iverilog -P testbench.WHALF="$WHALF" -P testbench.RHALF="$RHALF" -o sim \
  tb/tb_fifo.v "$TOP" "$WRPTR" "$RPTR" \
  rtl/dpram.v rtl/sync2.v rtl/width.v rtl/rst_bridge.v && vvp sim
