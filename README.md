## 16-Bit RISC Computer Design and Implementation

###  專案簡介
本專案為 **FPGA 系統設計與實作** 課程之期末專案。目標是設計並實作一台具備多週期架構（Multiple-cycle Architecture）的 **16 位元精簡指令集電腦 (RISC)**。

本設計涵蓋了從硬體規格定義、原理圖繪製（Schematic Entry）到 Verilog 硬體描述語言實作的完整流程。

---

###  開發環境
* **EDA 工具**: Xilinx ISE 14.7 WebPack
* **硬體平台**: Spartan-6 (XC6SLX25T) 
* **實作語言**: Verilog HDL, Schematic Entry

---

###  實作
- [x] **階段一：原理圖設計 (Schematic Entry)**
  - [x] Register File (RF) 實作
  - [x] 16-bit ALU 與旗標邏輯
  - [x] 控制單元 (Controller) 與狀態機設計
- [x] **階段二：Verilog HDL 轉換**
  - [x] RTL

---

###  系統架構
#### 1. 暫存器規格 (Programming Model)
* **通用暫存器 (GPRs)**: $R_0 \sim R_7$ (共 8 個 16-bit 暫存器)。
* **特殊暫存器**:
  * **PC (Program Counter)**: 16-bit 程式計數器。
  * **PSW (Program Status Word)**: 包含四個狀態旗標：$N$ (負數)、$Z$ (零)、$C$ (進位)、$V$ (溢位)。
  * **SP (Stack Pointer)**: 預設使用 $R_7$ 作為堆疊指標。

#### 2. 指令集架構 (ISA Summary)
根據課程規範與 Table 3 指令集定義，本處理器支援以下指令：

##### 🔹 資料傳輸 (Data Transfer)
* `MOV`: 暫存器間資料傳送。
* `LHI` / `LLI`: 載入立即值至暫存器高/低位元組。
* `LDR` / `STR`: 記憶體載入與儲存。

##### 🔹 算術與邏輯運算 (Arithmetic & Logic)
* **基礎運算**: `ADD`, `SUB`, `ADC`, `SBB`, `ADDI`, `SUBI`。
* **邏輯運算**: `CMP` (比較)。

##### 🔹 分支與跳躍 (Branch & Jump)
* `Bcond`: 條件跳躍 (基於 CC, CS, NE, EQ, [AL] 旗標)。
* `JMP`: 絕對跳躍。
* `JAL`: 跳躍並連結 (Jump and Link)。
* `JR`: 暫存器跳躍。

##### 🔹 堆疊與系統操作 (Stack & System)
* `OutR`: 輸出暫存器內容以利除錯。
* `HLT`: 停止執行並設置 Done 旗標。

---

###  檔案結構 (Project Structure)
* **`SChematic/`**: 存放所有電路的原理圖、Testbench與波形圖。
* **`HDL/`**: 存放與原理圖邏輯對應的 **Verilog (.v)** code, Testbench與波形圖。
* **`docs/`**: 存放專案說明文件、ISA 表格。

