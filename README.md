# 2025_Autumn_CPU_designing
This is the CPU designing assessment questions for NCUSCC.

指令参考手册：[2023041918122813624.龙芯架构32位精简版参考手册_r1p03.pdf (loongson.cn)](https://www.loongson.cn/uploads/images/2023041918122813624.龙芯架构32位精简版参考手册_r1p03.pdf)

Fibonacci:

```
├─func
│  └─obj
├─miniCPU
└─soc_verify
 ├─constraints
 ├─rtl
 │  ├─CONFREG
 │  ├─top
 │  └─xilinx_ip
 │      ├─clk_pll
 │      │  └─doc
 │      └─inst_ram
 │          ├─doc
 │          ├─hdl
 │      	├─sim
 │       	├─simulation
 │       	└─synth
 └─testbench
```

reg_chain:

	├─func
	│  └─obj
	├─miniCPU
	└─soc_verify
	 ├─constraints
	 ├─rtl
	 │  ├─CONFREG
	 │  ├─top
	 │  └─xilinx_ip
	 │      ├─clk_pll
	 │      │  └─doc
	 │      └─inst_ram
	 │          ├─doc
	 │          ├─hdl
	 │      	├─sim
	 │       	├─simulation
	 │       	└─synth
	 └─testbench

