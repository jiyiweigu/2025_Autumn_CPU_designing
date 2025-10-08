# 2025_Autumn_CPU_designing
This is the CPU designing assessment questions for NCUSCC.

指令参考手册：[2023041918122813624.龙芯架构32位精简版参考手册_r1p03.pdf (loongson.cn)](https://www.loongson.cn/uploads/images/2023041918122813624.龙芯架构32位精简版参考手册_r1p03.pdf)

Fibonacci:

```
├─func						  # 提供的实验函数编译文件夹
│  └─obj					  # 编译中间文件
├─miniCPU                     # 你应该实现的 CPU 设计，只需要完成minicpu_top.v设计即可，剩下的文件是默认环境文件
└─soc_verify				  # 测试约束文件和物理接口设置（默认环境，无需更改）
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
```
	├─func					  # 提供了脚本链接文件和相关汇编代码，你需要手动配置环境完成编译
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
两个环境除了使用的实验程序不同外，其他环境一致。

实验环境是精简化的龙芯被官方实验环境，在此基础上做了一些删改，原环境可见官网：
https://gitee.com/loongson-edu/cdp_ede_local

推荐用书：CPU设计实战（loongArch版）

初学者建议 HDL 调试环境：vivado 23.02